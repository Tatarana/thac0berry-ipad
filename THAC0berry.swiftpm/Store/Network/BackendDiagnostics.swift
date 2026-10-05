import Foundation
import CryptoKit

/// Teste mínimo de rede (Etapa 3, 2026-10-05): prova que o app no iPad fala
/// com o backend por HTTP puro (`URLSession`, sem biblioteca externa) e que o
/// login com Google funciona. Nada aqui grava no aparelho nem mexe no
/// `library.json`: a sessão vive só na memória da tela de diagnóstico.
enum BackendDiagnostics {

    struct Line: Identifiable {
        let id = UUID()
        let ok: Bool
        let text: String
    }

    struct Session {
        let accessToken: String
        let email: String
    }

    /// Par PKCE do login OAuth: o `verifier` fica no app; o `challenge`
    /// (SHA-256 dele) vai na URL de login.
    struct PKCE {
        let verifier: String
        let challenge: String
    }

    enum Failure: LocalizedError {
        case invalidURL
        case missingCode
        case provider(String)
        case badResponse(Int, String)

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL."
            case .missingCode:
                return "The sign-in returned no code."
            case .provider(let message):
                return "Provider error: \(message)"
            case .badResponse(let status, let body):
                return "HTTP \(status): \(body.prefix(200))"
            }
        }
    }

    // MARK: - Conexão (sem login)

    static func testConnection() async -> [Line] {
        let auth: Line = await probe(path: "/auth/v1/health", expected: 200, label: "Auth service")
        // Sem login, a API PRECISA recusar (as tabelas não dão acesso a anônimo).
        let api: Line = await probe(path: "/rest/v1/campaign?select=id&limit=1", expected: 401,
                                    label: "Data API refuses anonymous access")
        return [auth, api]
    }

    private static func probe(path: String, expected: Int, label: String) async -> Line {
        guard let url = URL(string: BackendConfig.baseURL + path) else {
            return Line(ok: false, text: "\(label): invalid URL")
        }
        var request = URLRequest(url: url)
        request.setValue(BackendConfig.publishableKey, forHTTPHeaderField: "apikey")
        let start = Date()
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            let status: Int = (response as? HTTPURLResponse)?.statusCode ?? -1
            let milliseconds = Int(Date().timeIntervalSince(start) * 1000)
            return Line(ok: status == expected,
                        text: "\(label): HTTP \(status) (expected \(expected)) · \(milliseconds) ms")
        } catch {
            return Line(ok: false, text: "\(label): \(error.localizedDescription)")
        }
    }

    // MARK: - Login (OAuth com PKCE)

    static func makePKCE() -> PKCE {
        let bytes: [UInt8] = (0..<32).map { _ in UInt8.random(in: 0...255) }
        let verifier = base64URL(Data(bytes))
        let digest = SHA256.hash(data: Data(verifier.utf8))
        return PKCE(verifier: verifier, challenge: base64URL(Data(digest)))
    }

    static func signInURL(provider: String, pkce: PKCE) -> URL? {
        var components = URLComponents(string: BackendConfig.baseURL + "/auth/v1/authorize")
        components?.queryItems = [
            URLQueryItem(name: "provider", value: provider),
            URLQueryItem(name: "redirect_to", value: BackendConfig.callbackURL),
            URLQueryItem(name: "code_challenge", value: pkce.challenge),
            URLQueryItem(name: "code_challenge_method", value: "s256"),
        ]
        return components?.url
    }

    /// Troca o `code` que voltou no `thac0berry://auth-callback?code=…` por
    /// uma sessão (token de acesso + e-mail).
    static func exchange(callback: URL, pkce: PKCE) async throws -> Session {
        let items: [URLQueryItem] = URLComponents(url: callback, resolvingAgainstBaseURL: false)?.queryItems ?? []
        if let message = items.first(where: { $0.name == "error_description" })?.value {
            throw Failure.provider(message)
        }
        guard let code = items.first(where: { $0.name == "code" })?.value else {
            throw Failure.missingCode
        }
        guard let url = URL(string: BackendConfig.baseURL + "/auth/v1/token?grant_type=pkce") else {
            throw Failure.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(BackendConfig.publishableKey, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["auth_code": code, "code_verifier": pkce.verifier]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        let status: Int = (response as? HTTPURLResponse)?.statusCode ?? -1
        guard status == 200 else {
            throw Failure.badResponse(status, String(decoding: data, as: UTF8.self))
        }
        let decoded = try JSONDecoder().decode(TokenResponse.self, from: data)
        return Session(accessToken: decoded.access_token, email: decoded.user?.email ?? "(no email)")
    }

    private struct TokenResponse: Decodable {
        struct User: Decodable {
            let email: String?
        }
        let access_token: String
        let user: User?
    }

    // MARK: - Leitura logado

    /// Já logado, a API deve aceitar a leitura (lista vazia, sem erro de
    /// permissão): prova que as regras de acesso da Fase 1 funcionam.
    static func signedInRead(session: Session) async -> Line {
        guard let url = URL(string: BackendConfig.baseURL + "/rest/v1/campaign?select=id") else {
            return Line(ok: false, text: "Signed-in read: invalid URL")
        }
        var request = URLRequest(url: url)
        request.setValue(BackendConfig.publishableKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(session.accessToken)", forHTTPHeaderField: "Authorization")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let status: Int = (response as? HTTPURLResponse)?.statusCode ?? -1
            guard status == 200 else {
                return Line(ok: false, text: "Signed-in read: HTTP \(status) — \(String(decoding: data, as: UTF8.self).prefix(200))")
            }
            let rows = (try? JSONSerialization.jsonObject(with: data)) as? [Any] ?? []
            return Line(ok: true, text: "Signed-in read: HTTP 200 · \(rows.count) campaign(s) on the server")
        } catch {
            return Line(ok: false, text: "Signed-in read: \(error.localizedDescription)")
        }
    }

    // MARK: - Utilitário

    private static func base64URL(_ data: Data) -> String {
        data.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
