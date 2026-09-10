//
//  ContentView.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @AppColorScheme private var colorScheme
    @ScreenProtectionEnabled private var screenProtectionEnabled

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                demosSection
                appearanceSection
                securitySection
            }
            .navigationTitle("Settings")
            .navigationDestination(for: DemoRoute.self) { route in
                route.view()
            }
        }
    }
}

// MARK: - Subviews

private extension ContentView {
    var demosSection: some View {
        Section {
            ForEach(DemoRoute.allCases) { route in
                NavigationLink(value: route) {
                    Label(route.title, systemImage: route.icon)
                }
            }
        } header: {
            Text("Demos")
        } footer: {
            Text("Explore various UI behaviors and animations.")
        }
    }

    var appearanceSection: some View {
        Section {
            Picker("Appearance", selection: $colorScheme) {
                ForEach(ColorSchemeOption.allCases, id: \.self) { option in
                    colorSchemeOptionLabel(option: option)
                        .tag(option)
                }
            }
        } header: {
            Text("Appearance")
        } footer: {
            Text("Choose how the app looks. System will match your device settings.")
        }
    }

    var securitySection: some View {
        Section {
            Toggle(isOn: $screenProtectionEnabled) {
                Label {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Screen Protection")
                            .font(.body)

                        Text(screenProtectionStatusText)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: screenProtectionEnabled ? "eye.slash.fill" : "eye.fill")
                        .contentTransition(.symbolEffect(.replace))
                        .foregroundStyle(screenProtectionEnabled ? .blue : .secondary)
                }
            }
        } header: {
            Text("Security")
        } footer: {
            Text(screenProtectionFooterText)
        }
    }

    func colorSchemeOptionLabel(option: ColorSchemeOption) -> some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text(option.rawValue)
                    .font(.body)

                Text(description(for: option))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } icon: {
            icon(for: option)
        }
    }

    func icon(for option: ColorSchemeOption) -> some View {
        Group {
            switch option {
            case .light:
                Image(systemName: "sun.max.fill")
                    .foregroundStyle(.yellow)
            case .dark:
                Image(systemName: "moon.fill")
                    .foregroundStyle(.indigo)
            case .system:
                Image(systemName: "circle.lefthalf.filled")
                    .foregroundStyle(.gray)
            }
        }
    }
}

// MARK: - Helpers

private extension ContentView {
    var screenProtectionStatusText: String {
        screenProtectionEnabled
            ? "Content is hidden during screen sharing"
            : "Content is visible during screen sharing"
    }

    var screenProtectionFooterText: String {
        "When enabled, app content will be blurred during screen recording " +
        "or screen sharing to protect sensitive information."
    }

    func description(for option: ColorSchemeOption) -> String {
        switch option {
        case .light:
            "Always use light mode"
        case .dark:
            "Always use dark mode"
        case .system:
            "Follow system setting"
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
