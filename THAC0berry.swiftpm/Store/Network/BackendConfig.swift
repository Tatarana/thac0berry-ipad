import Foundation

/// Endereço e chave PÚBLICA do backend (Supabase, repo `thac0berry-backend`).
/// A chave "publishable" foi feita para ir dentro do app: quem protege os
/// dados são as regras de permissão (RLS) do banco. A chave `service_role`
/// NUNCA entra no app nem no repo.
enum BackendConfig {
    static let baseURL = "https://azydmvnlzmyvtsgfogbq.supabase.co"
    static let publishableKey = "sb_publishable_VGUm2JdArmQuqeFBm1-Elg_ko24yZH2"

    /// Para onde o login devolve o usuário. Precisa estar na lista "Redirect
    /// URLs" do Supabase (Authentication → URL Configuration).
    static let callbackScheme = "thac0berry"
    static let callbackURL = "thac0berry://auth-callback"
}
