//
//  KeyboardDemoUIKitAnimation.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 28.01.26.
//

import SwiftUI

struct KeyboardDemoUIKitAnimation: View {
    @State private var text = ""
    @State private var isNumericKeyboard = false

    var body: some View {
        VStack(spacing: 24) {
            descriptionCard
            keyboardTypeIndicator
            textFieldSection
            toggleButton
            Spacer()
        }
        .padding()
        .navigationTitle("UIKit Animation")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - Subviews

private extension KeyboardDemoUIKitAnimation {
    var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("How it works", systemImage: "info.circle.fill")
                .font(.subheadline.bold())
                .foregroundStyle(.purple)

            // swiftlint:disable:next line_length
            Text("Uses UIViewRepresentable to wrap UITextField. Keyboard switching happens via reloadInputViews() with a custom crossDissolve animation. Provides the smoothest experience without losing focus.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.purple.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }

    var keyboardTypeIndicator: some View {
        HStack {
            Text("Current keyboard:")
            Text(isNumericKeyboard ? "Numeric" : "Alphabetic")
                .fontWeight(.semibold)
                .foregroundStyle(isNumericKeyboard ? .blue : .green)
                .contentTransition(.numericText())
        }
        .font(.headline)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.2), value: isNumericKeyboard)
    }

    var textFieldSection: some View {
        #if os(iOS)
        AnimatedKeyboardTextField(
            text: $text,
            isNumericKeyboard: $isNumericKeyboard,
            placeholder: "Type something..."
        )
        .frame(height: 44)
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
            isNumericKeyboard.toggle()
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

// MARK: - UIKit TextField Wrapper with Custom Animation

#if os(iOS)
struct AnimatedKeyboardTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isNumericKeyboard: Bool
    var placeholder: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.delegate = context.coordinator
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textFieldDidChange),
            for: .editingChanged
        )
        return textField
    }

    func updateUIView(_ textField: UITextField, context: Context) {
        if textField.text != text {
            textField.text = text
        }

        let newKeyboardType: UIKeyboardType = isNumericKeyboard ? .numberPad : .default
        if textField.keyboardType != newKeyboardType {
            textField.keyboardType = newKeyboardType

            if textField.isFirstResponder {
                UIView.transition(
                    with: textField.inputView ?? textField,
                    duration: 0.25,
                    options: .transitionCrossDissolve
                ) {
                    textField.reloadInputViews()
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
#endif

// MARK: - Preview

#Preview {
    NavigationStack {
        KeyboardDemoUIKitAnimation()
    }
}
