//
//  CardTransitionShowroomPage.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 10.09.26.
//

import SwiftUI

struct CardTransitionShowroomPage: View {
    // MARK: - Properties
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var cardNamespace

    private let cards: [HeroCard] = HeroCard.samples

    // MARK: - Body
    var body: some View {
        ScrollView {
            cardGrid
        }
        .background(Color(UIColor.systemGroupedBackground))
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
                cardLink(for: card)
            }
        }
        .padding(16)
    }

    func cardLink(for card: HeroCard) -> some View {
        NavigationLink(value: card) {
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
