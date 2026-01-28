//
//  CardScrollView.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 09.01.26.
//

import SwiftUI

struct CardScrollView<Content: View>: View {
    // MARK: - Properties
    @Binding var currentIndex: Int
    @State private var dragOffset: CGFloat = 0
    @GestureState private var isDragging: Bool = false

    private let cardCount: Int
    private let cardHeight: (Int) -> CGFloat
    private let cardContent: (Int) -> Content
    private let configuration: Configuration

    // MARK: - Init
    init(
        cardCount: Int,
        currentIndex: Binding<Int>,
        configuration: Configuration = .init(),
        @ViewBuilder cardContent: @escaping (Int) -> Content,
        cardHeight: @escaping (Int) -> CGFloat
    ) {
        self.cardCount = cardCount
        self._currentIndex = currentIndex
        self.configuration = configuration
        self.cardContent = cardContent
        self.cardHeight = cardHeight
    }

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = max(0, geometry.size.width - configuration.horizontalPadding * 2)

            ZStack(alignment: .top) {
                ForEach(0..<cardCount, id: \.self) { index in
                    cardContent(index)
                        .frame(width: cardWidth)
                        .frame(height: cardHeight(index))
                        .offset(y: cardOffset(for: index))
                        .zIndex(Double(cardCount - index))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .gesture(dragGesture)
            .padding(.horizontal, configuration.horizontalPadding)
            .padding(.top, configuration.topPadding)
        }
    }
}

// MARK: - Configuration
extension CardScrollView {
    struct Configuration {
        var cardSpacing: CGFloat = 20
        var horizontalPadding: CGFloat = 16
        var topPadding: CGFloat = 16
        var swipeThreshold: CGFloat = 50
        var velocityThreshold: CGFloat = 200
        var animationResponse: Double = 0.4
        var animationDamping: Double = 0.8
        var parallaxFactor: CGFloat = 0.3
    }
}

// MARK: - Gesture & Offset Calculations
private extension CardScrollView {
    func cardOffset(for index: Int) -> CGFloat {
        if index < currentIndex {
            return -cumulativeHeight(upTo: index) - CGFloat(index + 1) * configuration.cardSpacing - 100
        } else if index == currentIndex {
            return dragOffset
        } else {
            let baseOffset = cumulativeHeight(from: currentIndex, to: index)
            let spacingOffset = CGFloat(index - currentIndex) * configuration.cardSpacing
            return baseOffset + spacingOffset + dragOffset * configuration.parallaxFactor
        }
    }

    func cumulativeHeight(upTo index: Int) -> CGFloat {
        (0...index).reduce(0) { $0 + cardHeight($1) }
    }

    func cumulativeHeight(from startIndex: Int, to endIndex: Int) -> CGFloat {
        guard endIndex > startIndex else { return 0 }
        return (startIndex..<endIndex).reduce(0) { $0 + cardHeight($1) }
    }

    var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) { _, state, _ in
                state = true
            }
            .onChanged { value in
                dragOffset = value.translation.height
            }
            .onEnded { value in
                let velocity = value.predictedEndTranslation.height - value.translation.height
                let animation = Animation.spring(
                    response: configuration.animationResponse,
                    dampingFraction: configuration.animationDamping
                )

                withAnimation(animation) {
                    let swipedUp = value.translation.height < -configuration.swipeThreshold
                    let swipedDown = value.translation.height > configuration.swipeThreshold
                    let fastSwipeUp = velocity < -configuration.velocityThreshold
                    let fastSwipeDown = velocity > configuration.velocityThreshold

                    if swipedUp || fastSwipeUp {
                        if currentIndex < cardCount - 1 {
                            currentIndex += 1
                        }
                    } else if swipedDown || fastSwipeDown {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    dragOffset = 0
                }
            }
    }
}

// MARK: - Convenience Init for CardItem
extension CardScrollView where Content == CardView {
    init(
        cards: [CardItem],
        currentIndex: Binding<Int>,
        configuration: Configuration = .init()
    ) {
        self.init(
            cardCount: cards.count,
            currentIndex: currentIndex,
            configuration: configuration,
            cardContent: { index in
                CardView(card: cards[index])
            },
            cardHeight: { index in
                cards[index].height
            }
        )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var index = 0

    CardScrollView(
        cards: CardItem.samples,
        currentIndex: $index
    )
    .background(Color(UIColor.systemGroupedBackground))
}
