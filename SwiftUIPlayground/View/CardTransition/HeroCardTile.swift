//
//  HeroCardTile.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 10.09.26.
//

import SwiftUI

struct HeroCardTile: View {
    // MARK: - Properties
    let card: HeroCard

    static let cornerRadius: CGFloat = 24

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            background
            symbolBackdrop
            label
        }
        .aspectRatio(3 / 4, contentMode: .fit)
        .clipShape(.rect(cornerRadius: Self.cornerRadius))
        .shadow(color: card.tint.opacity(0.35), radius: 12, x: 0, y: 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(card.title), \(card.subtitle)")
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Subviews

private extension HeroCardTile {
    var background: some View {
        LinearGradient(
            colors: [card.tint, card.accent],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var symbolBackdrop: some View {
        Image(systemName: card.icon)
            .resizable()
            .scaledToFit()
            .frame(width: 96)
            .foregroundStyle(.white.opacity(0.22))
            .offset(x: 28, y: -20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }

    var label: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: card.icon)
                .font(.title3)
                .foregroundStyle(.white)

            Text(card.title)
                .font(.title2.bold())
                .foregroundStyle(.white)

            Text(card.subtitle)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(labelScrim)
    }

    var labelScrim: some View {
        LinearGradient(
            colors: [.black.opacity(0.35), .clear],
            startPoint: .bottom,
            endPoint: .top
        )
    }
}

// MARK: - Preview
#Preview {
    HeroCardTile(card: HeroCard.samples[0])
        .frame(width: 180)
        .padding()
}
