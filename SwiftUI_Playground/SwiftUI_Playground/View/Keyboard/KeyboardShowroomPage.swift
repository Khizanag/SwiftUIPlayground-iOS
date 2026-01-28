//
//  KeyboardShowroomPage.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 28.01.26.
//

import SwiftUI

struct KeyboardShowroomPage: View {
    var body: some View {
        List {
            Section {
                ForEach(KeyboardDemo.allCases) { demo in
                    NavigationLink(destination: demo.destination) {
                        demoRow(for: demo)
                    }
                }
            } header: {
                Text("Keyboard Switching Demos")
            } footer: {
                Text("Different approaches to switch keyboard types while the text field is focused.")
            }
        }
        .navigationTitle("Keyboard Showroom")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - Subviews

private extension KeyboardShowroomPage {
    func demoRow(for demo: KeyboardDemo) -> some View {
        Label {
            VStack(alignment: .leading, spacing: 4) {
                Text(demo.title)
                    .font(.headline)

                Text(demo.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        } icon: {
            Image(systemName: demo.icon)
                .foregroundStyle(demo.iconColor)
                .frame(width: 28)
        }
    }
}

// MARK: - Demo Model

enum KeyboardDemo: String, CaseIterable, Identifiable {
    case timerAnimation
    case uikitCustomAnimation
    case numberKeyTap
    case nativeKeyDetection

    var id: String { rawValue }

    var title: String {
        switch self {
        case .timerAnimation:
            "Timer + Native Animation"
        case .uikitCustomAnimation:
            "UIKit + Custom Animation"
        case .numberKeyTap:
            "123 Toolbar Button"
        case .nativeKeyDetection:
            "Native 123 Detection"
        }
    }

    var description: String {
        switch self {
        case .timerAnimation:
            "Switch keyboards with a small delay and native SwiftUI animation"
        case .uikitCustomAnimation:
            "UIKit wrapper with custom keyboard transition animation"
        case .numberKeyTap:
            "Toolbar with 123/ABC buttons above keyboard"
        case .nativeKeyDetection:
            "Detect when user types from 123 layout (no extra buttons)"
        }
    }

    var icon: String {
        switch self {
        case .timerAnimation:
            "timer"
        case .uikitCustomAnimation:
            "square.stack.3d.up"
        case .numberKeyTap:
            "textformat.123"
        case .nativeKeyDetection:
            "eye"
        }
    }

    var iconColor: Color {
        switch self {
        case .timerAnimation:
            .orange
        case .uikitCustomAnimation:
            .purple
        case .numberKeyTap:
            .blue
        case .nativeKeyDetection:
            .indigo
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .timerAnimation:
            KeyboardDemoTimerAnimation()
        case .uikitCustomAnimation:
            KeyboardDemoUIKitAnimation()
        case .numberKeyTap:
            KeyboardDemoNumberKeyTap()
        case .nativeKeyDetection:
            KeyboardDemoNativeKeyDetection()
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        KeyboardShowroomPage()
    }
}
