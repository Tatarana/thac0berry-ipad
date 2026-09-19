import SwiftUI
import UIKit

/// Rajada curta de brasa subindo — usada em efeitos como subir de nível. Um
/// `Canvas` + `TimelineView` já dá conta disso; não precisa de framework
/// externo.
struct EmberBurst: View {
    var isActive: Bool
    var particleCount: Int = 10

    private struct Particle {
        let seed: Double
        let startX: CGFloat
        let size: CGFloat
        let delay: Double
    }

    private let particles: [Particle]

    init(isActive: Bool, particleCount: Int = 10) {
        self.isActive = isActive
        self.particleCount = particleCount
        self.particles = (0..<particleCount).map { index in
            Particle(seed: Double(index),
                      startX: CGFloat.random(in: 0.15...0.85),
                      size: CGFloat.random(in: 2...4.5),
                      delay: Double(index) * 0.04 + Double.random(in: 0...0.08))
        }
    }

    var body: some View {
        TimelineView(.animation(paused: !isActive)) { timeline in
            Canvas { context, size in
                guard isActive else { return }
                let elapsed = timeline.date.timeIntervalSinceReferenceDate
                for particle in particles {
                    let localTime = (elapsed - particle.delay).truncatingRemainder(dividingBy: 1.4)
                    guard localTime > 0, localTime <= 1.0 else { continue }
                    let progress = localTime
                    let x = particle.startX * size.width + sin(progress * .pi * 2 + particle.seed) * 6
                    let y = size.height * (1 - progress)
                    let opacity = 1 - progress
                    let rect = CGRect(x: x - particle.size / 2, y: y - particle.size / 2,
                                       width: particle.size, height: particle.size)
                    context.opacity = opacity
                    context.fill(Path(ellipseIn: rect), with: .color(Ember.glowBright))
                }
            }
        }
        .allowsHitTesting(false)
    }
}

extension View {
    /// Sobrepõe uma rajada de brasa por cima da view enquanto `trigger`
    /// for `true`. Respeita "Reduzir Movimento" do sistema — quando
    /// ativado, a rajada some e só fica o efeito estático por baixo, sem
    /// quebrar o layout nem deixar um buraco vazio no lugar dela.
    func emberBurst(trigger: Bool, particleCount: Int = 10) -> some View {
        modifier(EmberBurstModifier(trigger: trigger, particleCount: particleCount))
    }
}

private struct EmberBurstModifier: ViewModifier {
    let trigger: Bool
    let particleCount: Int
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content.overlay {
            if trigger && !reduceMotion {
                EmberBurst(isActive: trigger, particleCount: particleCount)
            }
        }
    }
}

// MARK: - Sacudida (dano)

/// Sacudida curta e horizontal — Fase 6: dano na caixa de Hit Points ganha
/// um tremor, não só o número mudando. `GeometryEffect` porque precisa
/// animar quadro a quadro (um `withAnimation` comum só interpola A→B, não
/// dá o efeito de "tremida" indo e voltando várias vezes).
struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 7
    var shakesPerUnit: CGFloat = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(
            translationX: amount * sin(animatableData * .pi * shakesPerUnit), y: 0
        ))
    }
}

extension View {
    /// Sacode a view uma vez a cada mudança de `trigger` — um contador que
    /// só sobe, não um `Bool` (dano repetido em sequência precisa disparar
    /// de novo mesmo sem passar por `false` no meio).
    func shakeOnce(trigger: Int) -> some View {
        modifier(ShakeOnceModifier(trigger: trigger))
    }

    /// Brilho breve de uma cor por cima da view — cura, por exemplo (frasco
    /// de poção em vez de brasa: verde-água, não laranja). Sobe rápido e
    /// apaga sozinho.
    func flashOnce(trigger: Int, color: Color) -> some View {
        modifier(FlashOnceModifier(trigger: trigger, color: color))
    }
}

private struct ShakeOnceModifier: ViewModifier {
    let trigger: Int
    @State private var animatedValue: CGFloat = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .modifier(ShakeEffect(animatableData: animatedValue))
            .onChange(of: trigger) { _, _ in
                guard !reduceMotion else { return }
                animatedValue = 0
                withAnimation(.linear(duration: 0.4)) { animatedValue = 1 }
            }
    }
}

private struct FlashOnceModifier: ViewModifier {
    let trigger: Int
    let color: Color
    @State private var opacity: Double = 0

    func body(content: Content) -> some View {
        content
            .overlay(color.opacity(opacity).blendMode(.plusLighter).allowsHitTesting(false))
            .onChange(of: trigger) { _, _ in
                withAnimation(.easeOut(duration: 0.15)) { opacity = 0.45 }
                withAnimation(.easeIn(duration: 0.6).delay(0.15)) { opacity = 0 }
            }
    }
}
