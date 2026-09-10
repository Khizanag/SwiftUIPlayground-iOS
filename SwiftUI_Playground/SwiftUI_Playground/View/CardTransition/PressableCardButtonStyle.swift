//
//  PressableCardButtonStyle.swift
//  SwiftUI_Playground
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
            .animation(.spring(duration: 0.3, bounce: 0.35), value: configuration.isPressed)
    }
}

// MARK: - Helpers

private extension PressableCardButtonStyle {
    func scale(isPressed: Bool) -> CGFloat {
        guard isPressed, !reduceMotion else { return 1 }
        return 0.94
    }
}
