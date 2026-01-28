//
//  KeyboardDemoNumberKeyTap.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 28.01.26.
//

import SwiftUI

struct KeyboardDemoNumberKeyTap: View {
    @State private var text = ""
    @State private var showNumberKeyboard = false
    @State private var lastAction: String = "None"
    @State private var buttonStyle: ToolbarButtonStyle = .singleToggle

    var body: some View {
        VStack(spacing: 24) {
            descriptionCard
            buttonStylePicker
            keyboardStateCard
            textFieldSection
            Spacer()
        }
        .padding()
        .navigationTitle("123 Key Detection")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - Toolbar Button Style

enum ToolbarButtonStyle: String, CaseIterable, Identifiable {
    case bothButtons = "Both Buttons"
    case singleToggle = "Single Toggle"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .bothButtons:
            "Shows both 123 and ABC buttons"
        case .singleToggle:
            "Single button that toggles between 123/ABC"
        }
    }
}

// MARK: - Subviews

private extension KeyboardDemoNumberKeyTap {
    var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("How it works", systemImage: "info.circle.fill")
                .font(.subheadline.bold())
                .foregroundStyle(.blue)

            Text("Adds a toolbar above the keyboard with \"123\" and \"ABC\" buttons. Tapping \"123\" switches to the full Number Pad (large digits). Tapping \"ABC\" returns to alphabetic keyboard. This is the practical approach since iOS doesn't allow intercepting the system's 123 key.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }

    var buttonStylePicker: some View {
        Menu {
            ForEach(ToolbarButtonStyle.allCases) { style in
                Button {
                    buttonStyle = style
                    lastAction = "Style: \(style.rawValue)"
                } label: {
                    Label {
                        VStack(alignment: .leading) {
                            Text(style.rawValue)
                            Text(style.description)
                                .font(.caption)
                        }
                    } icon: {
                        if buttonStyle == style {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Button Style")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(buttonStyle.rawValue)
                        .font(.headline)
                }
                Spacer()
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }

    var keyboardStateCard: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Current keyboard:")
                Text(showNumberKeyboard ? "Number Pad" : "Alphabetic")
                    .fontWeight(.semibold)
                    .foregroundStyle(showNumberKeyboard ? .blue : .green)
                    .contentTransition(.numericText())
            }
            .font(.headline)
            .animation(.easeInOut(duration: 0.2), value: showNumberKeyboard)

            HStack {
                Text("Last action:")
                Text(lastAction)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }

    var textFieldSection: some View {
        #if os(iOS)
        AccessoryKeyboardTextField(
            text: $text,
            showNumberKeyboard: $showNumberKeyboard,
            buttonStyle: buttonStyle,
            onAction: { action in
                lastAction = action
            },
            placeholder: "Tap here, then use toolbar buttons..."
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
}

// MARK: - UIKit TextField with Accessory Toolbar

#if os(iOS)
struct AccessoryKeyboardTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var showNumberKeyboard: Bool
    var buttonStyle: ToolbarButtonStyle
    var onAction: (String) -> Void
    var placeholder: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no

        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textFieldDidChange),
            for: .editingChanged
        )

        let toolbar = makeToolbar(coordinator: context.coordinator)
        textField.inputAccessoryView = toolbar
        context.coordinator.textField = textField
        context.coordinator.toolbar = toolbar

        return textField
    }

    func updateUIView(_ textField: UITextField, context: Context) {
        if textField.text != text {
            textField.text = text
        }

        let newKeyboardType: UIKeyboardType = showNumberKeyboard ? .numberPad : .default
        if textField.keyboardType != newKeyboardType {
            textField.keyboardType = newKeyboardType

            if textField.isFirstResponder {
                UIView.transition(
                    with: textField.inputView ?? textField,
                    duration: 0.2,
                    options: .transitionCrossDissolve
                ) {
                    textField.reloadInputViews()
                }
            }
        }

        if context.coordinator.currentButtonStyle != buttonStyle {
            context.coordinator.currentButtonStyle = buttonStyle
            rebuildToolbar(textField: textField, coordinator: context.coordinator)
        }

        updateToolbar(coordinator: context.coordinator)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(
            text: $text,
            showNumberKeyboard: $showNumberKeyboard,
            buttonStyle: buttonStyle,
            onAction: onAction
        )
    }

    private func makeToolbar(coordinator: Coordinator) -> UIToolbar {
        let toolbar = KeyboardToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56)

        buildToolbarItems(toolbar: toolbar, coordinator: coordinator)

        return toolbar
    }

    private func rebuildToolbar(textField: UITextField, coordinator: Coordinator) {
        guard let toolbar = coordinator.toolbar else { return }
        buildToolbarItems(toolbar: toolbar, coordinator: coordinator)

        if textField.isFirstResponder {
            textField.reloadInputViews()
        }
    }

    private func buildToolbarItems(toolbar: UIToolbar, coordinator: Coordinator) {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 8

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: coordinator,
            action: #selector(Coordinator.doneButtonTapped)
        )

        switch coordinator.currentButtonStyle {
        case .bothButtons:
            let numberButton = UIBarButtonItem(
                title: "123",
                style: .plain,
                target: coordinator,
                action: #selector(Coordinator.numberButtonTapped)
            )
            numberButton.setTitleTextAttributes([
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ], for: .normal)

            let abcButton = UIBarButtonItem(
                title: "ABC",
                style: .plain,
                target: coordinator,
                action: #selector(Coordinator.abcButtonTapped)
            )
            abcButton.setTitleTextAttributes([
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ], for: .normal)

            toolbar.items = [fixedSpace, numberButton, abcButton, flexSpace, doneButton, fixedSpace]
            coordinator.numberButton = numberButton
            coordinator.abcButton = abcButton
            coordinator.toggleButton = nil

        case .singleToggle:
            let toggleButton = UIBarButtonItem(
                title: showNumberKeyboard ? "ABC" : "123",
                style: .plain,
                target: coordinator,
                action: #selector(Coordinator.toggleButtonTapped)
            )
            toggleButton.setTitleTextAttributes([
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ], for: .normal)

            toolbar.items = [fixedSpace, toggleButton, flexSpace, doneButton, fixedSpace]
            coordinator.toggleButton = toggleButton
            coordinator.numberButton = nil
            coordinator.abcButton = nil
        }
    }

    private func updateToolbar(coordinator: Coordinator) {
        switch coordinator.currentButtonStyle {
        case .bothButtons:
            coordinator.numberButton?.isEnabled = !showNumberKeyboard
            coordinator.abcButton?.isEnabled = showNumberKeyboard
            coordinator.numberButton?.tintColor = showNumberKeyboard ? .systemGray : .systemBlue
            coordinator.abcButton?.tintColor = showNumberKeyboard ? .systemBlue : .systemGray

        case .singleToggle:
            coordinator.toggleButton?.title = showNumberKeyboard ? "ABC" : "123"
            coordinator.toggleButton?.tintColor = .systemBlue
        }
    }

    class KeyboardToolbar: UIToolbar {
        private let bottomPadding: CGFloat = 12

        override var intrinsicContentSize: CGSize {
            var size = super.intrinsicContentSize
            size.height += bottomPadding
            return size
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            for subview in subviews {
                if String(describing: type(of: subview)).contains("ContentView") {
                    var frame = subview.frame
                    frame.origin.y = 0
                    frame.size.height = bounds.height - bottomPadding
                    subview.frame = frame
                }
            }
        }
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var showNumberKeyboard: Bool
        var currentButtonStyle: ToolbarButtonStyle
        var onAction: (String) -> Void

        weak var textField: UITextField?
        weak var toolbar: UIToolbar?
        var numberButton: UIBarButtonItem?
        var abcButton: UIBarButtonItem?
        var toggleButton: UIBarButtonItem?

        init(
            text: Binding<String>,
            showNumberKeyboard: Binding<Bool>,
            buttonStyle: ToolbarButtonStyle,
            onAction: @escaping (String) -> Void
        ) {
            _text = text
            _showNumberKeyboard = showNumberKeyboard
            self.currentButtonStyle = buttonStyle
            self.onAction = onAction
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
        }

        @objc func numberButtonTapped() {
            showNumberKeyboard = true
            onAction("123 button tapped")
        }

        @objc func abcButtonTapped() {
            showNumberKeyboard = false
            onAction("ABC button tapped")
        }

        @objc func toggleButtonTapped() {
            showNumberKeyboard.toggle()
            onAction(showNumberKeyboard ? "Switched to 123" : "Switched to ABC")
        }

        @objc func doneButtonTapped() {
            textField?.resignFirstResponder()
            onAction("Done")
        }
    }
}
#endif

// MARK: - Preview

#Preview {
    NavigationStack {
        KeyboardDemoNumberKeyTap()
    }
}
