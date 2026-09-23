import SwiftUI

/// Pisca uma cor de destaque por alguns segundos atrás de um campo que
/// acabou de ser alterado por uma ação AUTOMÁTICA (não pelo jogador
/// digitando) — pedido do usuário ao ver o seletor de Raça mexer em
/// atributo/resistência mágica sozinho: "dá pra deixar o novo valor numa
/// outra cor por alguns segundos? Assim fica claro pro player o que
/// mudou". Funciona em cima de `PlayerCharacter.recentAutoChanges`
/// (`Models/Character.swift`) — quem aplica a mudança automática chama
/// `character.markRecentAutoChange("strength")` etc.; este modifier, na
/// linha da tela que mostra aquele campo, lê a marca, dispara a animação
/// e some sozinho.
///
/// É um FUNDO (não cor de texto) de propósito: funciona igual em cima de
/// qualquer conteúdo — `EditableNumber`, `EditableText`, `HandValue` —
/// sem precisar que cada componente aceite uma cor de texto dinâmica.
///
/// Não usa timer/relógio de parede: o contador só começa quando o campo
/// de fato aparece na tela (`onAppear`)/muda de estado, então escolher
/// uma raça na aba "Description" e só depois abrir a aba "Sheet" ainda
/// mostra o atributo piscando ali — em vez de a animação já ter
/// terminado escondida numa aba que o jogador nem tinha aberto ainda.
struct ChangeFlash: ViewModifier {
    @Binding var character: PlayerCharacter
    let key: String

    /// Verde-menta do `ConsequenceSignalBadge` — mesma linguagem visual
    /// já usada pra "algo mudou automaticamente" no resto do app, em vez
    /// de inventar uma cor nova só pra isso.
    var color: Color = Ember.mintGlow

    @State private var isFlashing = false
    @State private var hasScheduledClear = false

    // Usuário relatou (v1.24, 2026-09-22) que a piscada "está muito sutil
    // que nem vejo" — fundo a 0.45 de opacidade sobre o papel claro
    // ficava fraco demais pra notar de relance. Subiu pra 0.75 de fundo
    // MAIS uma borda sólida da mesma cor (o fundo sozinho, principalmente
    // em cima de campos pequenos como os de atributo, quase não aparecia;
    // a borda dá um contorno nítido mesmo quando a área do campo é
    // pequena) e o tempo aceso foi de 2.2s pra 3.2s, pra dar mais chance
    // de notar sem atrapalhar quem está preenchendo a ficha em sequência.
    func body(content: Content) -> some View {
        let shouldFlash = character.hasRecentAutoChange(key)

        content
            .background(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color.opacity(isFlashing ? 0.75 : 0))
                    .padding(-3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: isFlashing ? 2.5 : 0)
                    .padding(-3)
            )
            .onAppear { sync(shouldFlash) }
            .onChange(of: shouldFlash) { _, newValue in sync(newValue) }
    }

    private func sync(_ shouldFlash: Bool) {
        guard shouldFlash, !hasScheduledClear else { return }
        hasScheduledClear = true
        withAnimation(.easeIn(duration: 0.18)) { isFlashing = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            withAnimation(.easeOut(duration: 0.7)) { isFlashing = false }
            character.clearRecentAutoChange(key)
            hasScheduledClear = false
        }
    }
}

extension View {
    /// `key` usa o mesmo vocabulário de `PlayerCharacter.lastChangedField`
    /// ("strength", "dexterity", "constitution", "intelligence", "wisdom",
    /// "charisma") mais chaves próprias de campos que aquele sinal não
    /// cobre ("spellResistance", "racialAbilities", ...).
    func changeFlash(character: Binding<PlayerCharacter>, key: String) -> some View {
        modifier(ChangeFlash(character: character, key: key))
    }
}

/// Versão de `ChangeFlash` pra chamadores que só têm uma chave OPCIONAL
/// (ex. `AbilityRowForm.flashKey`, que continua `nil` em qualquer
/// chamada antiga) — com `key == nil` simplesmente devolve o conteúdo
/// sem mexer em nada, sem precisar de um `if` espalhado em cada call
/// site.
struct OptionalChangeFlash: ViewModifier {
    @Binding var character: PlayerCharacter
    let key: String?

    func body(content: Content) -> some View {
        if let key {
            content.changeFlash(character: $character, key: key)
        } else {
            content
        }
    }
}
