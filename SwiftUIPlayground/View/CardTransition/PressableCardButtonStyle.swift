//
//  PressableCardButtonStyle.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 10.09.26.
//

import SwiftUI

struct PressableCardButtonStyle: ButtonStyle {
    // MARK: - Properties
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // MARK: - Body
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(scale(isPressed: configuration.isPressed))
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}

// MARK: - Helpers

private extension PressableCardButtonStyle {
    func scale(isPressed: Bool) -> CGFloat {
        guard isPressed, !reduceMotion else { return 1 }
        return 0.97
    }
}
