//
//  CardView.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 09.01.26.
//

import SwiftUI

struct CardView: View {
    let card: CardItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerSection
            Divider()
            descriptionSection
            bulletPointsSection
            Spacer(minLength: 0)
            footerSection
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground)
        .overlay(cardBorder)
    }
}

// MARK: - Private Views
private extension CardView {
    var headerSection: some View {
        HStack(spacing: 14) {
            Image(systemName: card.icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(card.color.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: card.color.opacity(0.4), radius: 8, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.title.bold())
                    .foregroundColor(.primary)

                Text(card.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }

    var descriptionSection: some View {
        Text(card.description)
            .font(.body)
            .foregroundColor(.secondary)
            .lineSpacing(4)
    }

    var bulletPointsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(card.bulletPoints, id: \.self) { point in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(card.color)
                        .font(.body)

                    Text(point)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.top, 8)
    }

    var footerSection: some View {
        HStack {
            Spacer()
            Text("Swipe to navigate")
                .font(.caption)
                .foregroundStyle(.tertiary)
            Image(systemName: "arrow.up.arrow.down")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
    }

    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(UIColor.systemBackground))
            .shadow(color: .black.opacity(0.12), radius: 16, x: 0, y: 8)
    }

    var cardBorder: some View {
        RoundedRectangle(cornerRadius: 20)
            .strokeBorder(
                LinearGradient(
                    colors: [card.color.opacity(0.6), card.color.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 2
            )
    }
}

// MARK: - Preview
#Preview {
    CardView(card: CardItem.samples[0])
        .frame(width: 350, height: 420)
        .padding()
}
