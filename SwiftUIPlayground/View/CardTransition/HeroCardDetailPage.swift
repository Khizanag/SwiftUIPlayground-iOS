//
//  HeroCardDetailPage.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 10.09.26.
//

import SwiftUI

struct HeroCardDetailPage: View {
    // MARK: - Properties
    let card: HeroCard

    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    // MARK: - Body
    var body: some View {
        ZStack {
            background
            content
        }
        .navigationTitle(card.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

// MARK: - Subviews

private extension HeroCardDetailPage {
    var background: some View {
        LinearGradient(
            colors: [card.tint, card.accent],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                hero
                details
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }

    var hero: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(card.subtitle.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.8))

            Text(card.title)
                .font(.largeTitle.bold())
                .foregroundStyle(.white)

            Text(card.tagline)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 24)
        .overlay(alignment: .topTrailing) { symbolBackdrop }
    }

    var symbolBackdrop: some View {
        Image(systemName: card.icon)
            .resizable()
            .scaledToFit()
            .frame(width: 130)
            .foregroundStyle(.white.opacity(0.25))
            .offset(x: 30, y: -30)
            .allowsHitTesting(false)
    }

    var details: some View {
        VStack(alignment: .leading, spacing: 16) {
            statsSection
            storySection
            highlightsSection
        }
    }

    var statsSection: some View {
        HStack(spacing: 12) {
            ForEach(card.stats) { stat in
                statTile(stat)
            }
        }
    }

    func statTile(_ stat: HeroCard.Stat) -> some View {
        VStack(spacing: 4) {
            Text(stat.value)
                .font(.headline)

            Text(stat.label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .surface(surfaceStyle)
    }

    var storySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.headline)

            Text(card.story)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .surface(surfaceStyle)
    }

    var highlightsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Highlights")
                .font(.headline)

            ForEach(card.highlights, id: \.self) { highlight in
                highlightRow(highlight)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .surface(surfaceStyle)
    }

    func highlightRow(_ highlight: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.secondary)

            Text(highlight)
                .font(.subheadline)

            Spacer(minLength: 0)
        }
    }
}

// MARK: - Helpers

private extension HeroCardDetailPage {
    /// Opaque fallback keeps the sections readable when Reduce Transparency is on.
    var surfaceStyle: AnyShapeStyle {
        reduceTransparency
            ? AnyShapeStyle(.background)
            : AnyShapeStyle(.regularMaterial)
    }
}

// MARK: - Surface

private extension View {
    func surface(_ style: AnyShapeStyle, cornerRadius: CGFloat = 20) -> some View {
        padding(16)
            .background(style, in: .rect(cornerRadius: cornerRadius))
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        HeroCardDetailPage(card: HeroCard.samples[0])
    }
}
