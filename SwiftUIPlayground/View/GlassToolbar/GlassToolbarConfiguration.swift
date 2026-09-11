//
//  GlassToolbarConfiguration.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 11.09.26.
//

import SwiftUI

/// Every knob the Glass Toolbar scene exposes, in one value.
struct GlassToolbarConfiguration {
    // Toolbar content
    var usesSpacer = true
    var spacerSizing: SpacerSizing = .flexible
    var groupSharesBackground = true
    var buttonTreatment: ButtonTreatment = .glass
    var tint: TintOption = .none

    // Bar chrome
    var barBackground: BarBackground = .automatic
    var barColorScheme: BarColorScheme = .automatic
    var titleDisplay: TitleDisplay = .automatic
    var showsSubtitle = true
    var role: BarRole = .automatic

    // Scroll edge
    var scrollEdge: ScrollEdgeStyle = .automatic
    var scrollEdgeTarget: EdgeTarget = .top

    // Bottom bar and free-standing glass
    var showsBottomBar = true
    var unionsGlassButtons = false
    var glassVariant: GlassVariant = .regular
    var isGlassInteractive = true
    var extendsHeaderBackground = true

    var subtitle: String? {
        showsSubtitle ? "iOS 26 Liquid Glass" : nil
    }
}

// MARK: - Toolbar content
extension GlassToolbarConfiguration {
    enum SpacerSizing: String, CaseIterable, Identifiable {
        case fixed
        case flexible

        var id: Self { self }
        var label: String { rawValue.capitalized }
    }

    enum ButtonTreatment: String, CaseIterable, Identifiable {
        case glass
        case glassProminent
        case borderless

        var id: Self { self }

        var label: String {
            switch self {
            case .glass:
                "Glass"
            case .glassProminent:
                "Prominent"
            case .borderless:
                "Borderless"
            }
        }
    }

    enum TintOption: String, CaseIterable, Identifiable {
        case none
        case blue
        case pink
        case green

        var id: Self { self }
        var label: String { rawValue.capitalized }

        var color: Color? {
            switch self {
            case .none:
                nil
            case .blue:
                .blue
            case .pink:
                .pink
            case .green:
                .green
            }
        }
    }
}

// MARK: - Bar chrome
extension GlassToolbarConfiguration {
    enum BarBackground: String, CaseIterable, Identifiable {
        case automatic
        case visible
        case hidden

        var id: Self { self }
        var label: String { rawValue.capitalized }

        var visibility: Visibility {
            switch self {
            case .automatic:
                .automatic
            case .visible:
                .visible
            case .hidden:
                .hidden
            }
        }
    }

    enum BarColorScheme: String, CaseIterable, Identifiable {
        case automatic
        case light
        case dark

        var id: Self { self }
        var label: String { rawValue.capitalized }

        var scheme: ColorScheme? {
            switch self {
            case .automatic:
                nil
            case .light:
                .light
            case .dark:
                .dark
            }
        }
    }

    enum TitleDisplay: String, CaseIterable, Identifiable {
        case automatic
        case inline
        case large
        case inlineLarge

        var id: Self { self }

        var label: String {
            switch self {
            case .inlineLarge:
                "Inline Large"
            default:
                rawValue.capitalized
            }
        }

        var mode: ToolbarTitleDisplayMode {
            switch self {
            case .automatic:
                .automatic
            case .inline:
                .inline
            case .large:
                .large
            case .inlineLarge:
                .inlineLarge
            }
        }
    }

    enum BarRole: String, CaseIterable, Identifiable {
        case automatic
        case navigationStack
        case editor
        case browser

        var id: Self { self }

        var label: String {
            switch self {
            case .navigationStack:
                "Nav Stack"
            default:
                rawValue.capitalized
            }
        }

        var role: ToolbarRole {
            switch self {
            case .automatic:
                .automatic
            case .navigationStack:
                .navigationStack
            case .editor:
                .editor
            case .browser:
                .browser
            }
        }
    }
}

// MARK: - Scroll edge and glass
extension GlassToolbarConfiguration {
    enum ScrollEdgeStyle: String, CaseIterable, Identifiable {
        case automatic
        case soft
        case hard

        var id: Self { self }
        var label: String { rawValue.capitalized }
    }

    enum EdgeTarget: String, CaseIterable, Identifiable {
        case top
        case bottom
        case all

        var id: Self { self }
        var label: String { rawValue.capitalized }

        var edges: Edge.Set {
            switch self {
            case .top:
                .top
            case .bottom:
                .bottom
            case .all:
                .all
            }
        }
    }

    enum GlassVariant: String, CaseIterable, Identifiable {
        case regular
        case clear

        var id: Self { self }
        var label: String { rawValue.capitalized }

        var glass: Glass {
            switch self {
            case .regular:
                .regular
            case .clear:
                .clear
            }
        }
    }

    /// The `Glass` value the free-standing panel uses, with tint and
    /// interactivity folded in.
    var panelGlass: Glass {
        let base = glassVariant.glass
        let tinted = tint.color.map { base.tint($0) } ?? base
        return tinted.interactive(isGlassInteractive)
    }
}
