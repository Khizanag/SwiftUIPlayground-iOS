//
//  KeyboardDemoNativeKeyDetection.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 28.01.26.
//

import SwiftUI

struct KeyboardDemoNativeKeyDetection: View {
    @State private var text = ""
    @State private var showNumberKeyboard = false
    @State private var lastDetection: String = "None"
    @State private var detectionMode: DetectionMode = .autoSwitch

    var body: some View {
        VStack(spacing: 24) {
            descriptionCard
            detectionModePicker
            keyboardStateCard
            textFieldSection
            Spacer()
        }
        .padding()
        .navigationTitle("Native 123 Detection")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - Detection Mode

enum DetectionMode: String, CaseIterable, Identifiable {
    case autoSwitch = "Auto Switch"
    case detectOnly = "Detect Only"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .autoSwitch:
            "Automatically switch to Number Pad when 123 detected"
        case .detectOnly:
            "Only detect and show alert, don't switch keyboard"
        }
    }
}

// MARK: - Subviews

private extension KeyboardDemoNativeKeyDetection {
    var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("How it works", systemImage: "info.circle.fill")
                .font(.subheadline.bold())
                .foregroundStyle(.indigo)

            Text("Detects when user types a number or symbol on the alphabetic keyboard (meaning they tapped \"123\"). No toolbar buttons needed. When detected, can auto-switch to full Number Pad.")
                .font(.caption)
                .foregroundStyle(.secondary)

            Divider()
                .padding(.vertical, 4)

            Label("Limitation", systemImage: "exclamationmark.triangle.fill")
                .font(.caption.bold())
                .foregroundStyle(.orange)

            Text("Detection happens after the first character is typed on the 123 layout, not on the actual button tap (iOS doesn't expose that event).")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.indigo.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
    }

    var detectionModePicker: some View {
        Menu {
            ForEach(DetectionMode.allCases) { mode in
                Button {
                    detectionMode = mode
                } label: {
                    Label {
                        VStack(alignment: .leading) {
                            Text(mode.rawValue)
                            Text(mode.description)
                                .font(.caption)
                        }
                    } icon: {
                        if detectionMode == mode {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Detection Mode")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(detectionMode.rawValue)
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
                Text("Last detection:")
                Text(lastDetection)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            .font(.subheadline)

            if showNumberKeyboard {
                Button {
                    showNumberKeyboard = false
                    lastDetection = "Manual reset to ABC"
                } label: {
                    Label("Back to Alphabetic", systemImage: "textformat.abc")
                        .font(.subheadline)
                }
                .buttonStyle(.bordered)
                .padding(.top, 4)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }

    var textFieldSection: some View {
        #if os(iOS)
        NativeKeyDetectionTextField(
            text: $text,
            showNumberKeyboard: $showNumberKeyboard,
            detectionMode: detectionMode,
            onDetection: { detection in
                lastDetection = detection
            },
            placeholder: "Type here - try tapping 123 then a number..."
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

// MARK: - UIKit TextField with Native Key Detection

#if os(iOS)
struct NativeKeyDetectionTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var showNumberKeyboard: Bool
    var detectionMode: DetectionMode
    var onDetection: (String) -> Void
    var placeholder: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.smartQuotesType = .no
        textField.smartDashesType = .no

        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textFieldDidChange),
            for: .editingChanged
        )

        context.coordinator.textField = textField

        return textField
    }

    func updateUIView(_ textField: UITextField, context: Context) {
        if textField.text != text {
            textField.text = text
        }

        context.coordinator.detectionMode = detectionMode

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
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(
            text: $text,
            showNumberKeyboard: $showNumberKeyboard,
            detectionMode: detectionMode,
            onDetection: onDetection
        )
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var showNumberKeyboard: Bool
        var detectionMode: DetectionMode
        var onDetection: (String) -> Void

        weak var textField: UITextField?

        private let numberAndSymbolCharacters = CharacterSet.decimalDigits
            .union(CharacterSet.punctuationCharacters)
            .union(CharacterSet.symbols)
            .union(CharacterSet(charactersIn: "@#$%^&*()_+-=[]{}|;':\",./<>?`~"))

        init(
            text: Binding<String>,
            showNumberKeyboard: Binding<Bool>,
            detectionMode: DetectionMode,
            onDetection: @escaping (String) -> Void
        ) {
            _text = text
            _showNumberKeyboard = showNumberKeyboard
            self.detectionMode = detectionMode
            self.onDetection = onDetection
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
        }

        func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            guard !showNumberKeyboard,
                  !string.isEmpty,
                  textField.keyboardType == .default else {
                return true
            }

            let stringCharacterSet = CharacterSet(charactersIn: string)

            if numberAndSymbolCharacters.isSuperset(of: stringCharacterSet) {
                let detectedChar = string.first.map { String($0) } ?? string
                onDetection("Detected: \"\(detectedChar)\" from 123 layout")

                if detectionMode == .autoSwitch {
                    DispatchQueue.main.async {
                        self.showNumberKeyboard = true
                    }
                }
            }

            return true
        }
    }
}
#endif

// MARK: - Preview

#Preview {
    NavigationStack {
        KeyboardDemoNativeKeyDetection()
    }
}
