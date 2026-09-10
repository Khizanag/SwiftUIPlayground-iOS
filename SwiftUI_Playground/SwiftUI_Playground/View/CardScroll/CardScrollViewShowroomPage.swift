//
//  CardScrollViewShowroomPage.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 09.01.26.
//

import SwiftUI

/// Gesture example: a hand-rolled snap scroller.
///
/// Cards of differing height stack, trail behind with a parallax offset, and
/// settle on a spring. A `DragGesture` and its end velocity drive the current
/// index, rather than `ScrollView` paging, so each card keeps its own geometry.
struct CardScrollViewShowroomPage: View {
    // MARK: - Properties
    @State private var currentIndex: Int = 0

    private let cards: [CardItem] = CardItem.samples

    // MARK: - Body
    var body: some View {
        CardScrollView(
            cards: cards,
            currentIndex: $currentIndex
        )
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Cards (\(currentIndex + 1)/\(cards.count))")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                cardIndicator
            }
        }
    }
}

// MARK: - Private Views
private extension CardScrollViewShowroomPage {
    var cardIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<cards.count, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.accentColor : Color.secondary.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .scaleEffect(index == currentIndex ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: currentIndex)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CardScrollViewShowroomPage()
    }
}
