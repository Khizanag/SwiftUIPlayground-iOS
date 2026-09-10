//
//  CardTransitionShowroomPage.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 10.09.26.
//

import SwiftUI

/// Navigation animation example: a card that becomes the page.
///
/// Every tile is a `matchedTransitionSource` and the pushed page carries the
/// matching `.navigationTransition(.zoom(sourceID:in:))`, so a tap morphs the
/// card into a full detail page and Back reverses the morph. The push goes
/// through `Navigator`, not a `NavigationLink` — the zoom binds to the source
/// and the destination's `sourceID`, so how the value reaches the path is
/// irrelevant. What does matter: the page is built only when pushed, so it
/// registers its destination — and its `@Namespace` — once. Build it eagerly
/// and the destination is registered twice, and the zoom degrades to a slide.
struct CardTransitionShowroomPage: View {
    // MARK: - Properties
    @Environment(Navigator.self) private var navigator
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var cardNamespace

    private let cards: [HeroCard] = HeroCard.samples

    // MARK: - Body
    var body: some View {
        ScrollView {
            cardGrid
        }
        .background(.background.secondary)
        .navigationTitle("Card Transition")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: HeroCard.self) { card in
            detailPage(for: card)
        }
    }
}

// MARK: - Subviews

private extension CardTransitionShowroomPage {
    var cardGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(cards) { card in
                cardButton(for: card)
            }
        }
        .padding(16)
    }

    func cardButton(for card: HeroCard) -> some View {
        Button {
            navigator.push(card)
        } label: {
            HeroCardTile(card: card)
        }
        .buttonStyle(PressableCardButtonStyle())
        .matchedTransitionSource(id: card.id, in: cardNamespace) { source in
            source.clipShape(.rect(cornerRadius: HeroCardTile.cornerRadius))
        }
    }

    @ViewBuilder
    func detailPage(for card: HeroCard) -> some View {
        if reduceMotion {
            HeroCardDetailPage(card: card)
        } else {
            HeroCardDetailPage(card: card)
                .navigationTransition(.zoom(sourceID: card.id, in: cardNamespace))
        }
    }
}

// MARK: - Helpers

private extension CardTransitionShowroomPage {
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150), spacing: 16)]
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CardTransitionShowroomPage()
    }
}
