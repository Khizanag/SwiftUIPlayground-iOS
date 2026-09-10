//
//  KeyboardDemoTimerAnimation.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 28.01.26.
//

import SwiftUI

struct KeyboardDemoTimerAnimation: View {
    @State private var text = ""
    @State private var isNumericKeyboard = false
    @State private var displayedKeyboardType: Bool = false
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 24) {
            descriptionCard
            keyboardTypeIndicator
            textFieldSection
            toggleButton
            Spacer()
        }
        .padding()
        .navigationTitle("Timer Animation")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - Subviews

private extension KeyboardDemoTimerAnimation {
    var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("How it works", systemImage: "info.circle.fill")
                .font(.subheadline.bold())
                .foregroundStyle(.orange)

            // swiftlint:disable:next line_length
            Text("Uses a small timer delay (0.1s) before switching keyboard types. The native SwiftUI animation smooths the transition. This approach is simple but may have a slight visual flicker.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.orange.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }

    var keyboardTypeIndicator: some View {
        HStack {
            Text("Current keyboard:")
            Text(displayedKeyboardType ? "Numeric" : "Alphabetic")
                .fontWeight(.semibold)
                .foregroundStyle(displayedKeyboardType ? .blue : .green)
                .contentTransition(.numericText())
        }
        .font(.headline)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.2), value: displayedKeyboardType)
    }

    var textFieldSection: some View {
        #if os(iOS)
        TextField("Type something...", text: $text)
            .keyboardType(isNumericKeyboard ? .numberPad : .default)
            .focused($isFocused)
            .font(.title3)
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        #else
        TextField("Type something...", text: $text)
            .textFieldStyle(.roundedBorder)
            .font(.title3)
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        #endif
    }

    var toggleButton: some View {
        Button {
            switchKeyboard()
        } label: {
            Label(
                isNumericKeyboard ? "Switch to Alphabetic" : "Switch to Numeric",
                systemImage: isNumericKeyboard ? "textformat.abc" : "number"
            )
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
        }
        .buttonStyle(.borderedProminent)
    }
}

// MARK: - Actions

private extension KeyboardDemoTimerAnimation {
    func switchKeyboard() {
        let wasFocused = isFocused

        if wasFocused {
            isFocused = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.2)) {
                isNumericKeyboard.toggle()
                displayedKeyboardType.toggle()
            }

            if wasFocused {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    isFocused = true
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        KeyboardDemoTimerAnimation()
    }
}
