//
//  GlassToolbarShowroomPage.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 11.09.26.
//

import SwiftUI

/// Liquid Glass example: the navigation bar and toolbar, live-configurable.
///
/// Every control below rewrites this page's own chrome, so the bar you are
/// looking at is the specimen: toolbar items and `ToolbarSpacer`, shared group
/// backgrounds, glass button styles, bar background visibility and colour
/// scheme, title display mode and subtitle, toolbar role, scroll edge effects,
/// a `safeAreaBar` of glass actions, and free-standing `glassEffect` surfaces
/// inside a `GlassEffectContainer`.
struct GlassToolbarShowroomPage: View {
    // MARK: - Properties
    @State private var configuration = GlassToolbarConfiguration()
    @Namespace private var glassNamespace

    // MARK: - Body
    var body: some View {
        content
            .navigationTitle("Glass Toolbar")
            .toolbarTitleDisplayMode(configuration.titleDisplay.mode)
            .toolbarBackgroundVisibility(configuration.barBackground.visibility, for: .navigationBar)
            .toolbarColorScheme(configuration.barColorScheme.scheme, for: .navigationBar)
            .toolbarRole(configuration.role.role)
            .toolbar { toolbarContent }
            .tint(configuration.tint.color)
            .ifLet(configuration.subtitle) { page, subtitle in
                page.navigationSubtitle(subtitle)
            }
    }
}

// MARK: - Subviews
private extension GlassToolbarShowroomPage {
    @ViewBuilder var content: some View {
        if configuration.showsBottomBar {
            scrollingContent
                .safeAreaBar(edge: .bottom) { bottomBar }
        } else {
            scrollingContent
        }
    }

    var scrollingContent: some View {
        scrollEdgeStyled(
            ScrollView {
                VStack(spacing: 20) {
                    header
                    glassPanel
                    GlassToolbarControls(configuration: $configuration)
                }
                .padding(20)
            }
        )
    }

    var header: some View {
        LinearGradient(
            colors: [.indigo, .purple, .pink],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(height: 140)
        .clipShape(.rect(cornerRadius: 24))
        .backgroundExtensionEffect(isEnabled: configuration.extendsHeaderBackground)
        .overlay(alignment: .bottomLeading) { headerLabel }
    }

    var headerLabel: some View {
        Text(configuration.extendsHeaderBackground ? "Background extended" : "Background clipped")
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(16)
    }

    var glassPanel: some View {
        GlassEffectContainer(spacing: 16) {
            HStack(spacing: 16) {
                ForEach(panelSymbols, id: \.self) { symbol in
                    panelChip(symbol)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    func panelChip(_ symbol: String) -> some View {
        Image(systemName: symbol)
            .font(.title2)
            .frame(width: 64, height: 64)
            .glassEffect(configuration.panelGlass, in: .rect(cornerRadius: 20))
            .glassEffectUnion(id: unionID(for: symbol), namespace: glassNamespace)
    }

    var bottomBar: some View {
        GlassEffectContainer(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(barActions, id: \.self) { symbol in
                    treated(barButton(symbol))
                }
            }
        }
        .padding(.horizontal, 20)
    }

    func barButton(_ symbol: String) -> some View {
        Button {} label: {
            Image(systemName: symbol)
                .frame(maxWidth: .infinity)
        }
        .accessibilityLabel(symbol)
    }
}

// MARK: - Toolbar
private extension GlassToolbarShowroomPage {
    @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            treated(toolbarButton("line.3.horizontal.decrease"))
        }

        if configuration.usesSpacer {
            toolbarSpacer
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
            treated(toolbarButton("square.and.arrow.up"))
            treated(toolbarButton("ellipsis"))
        }
        .sharedBackgroundVisibility(configuration.groupSharesBackground ? .automatic : .hidden)
    }

    @ToolbarContentBuilder var toolbarSpacer: some ToolbarContent {
        switch configuration.spacerSizing {
        case .fixed:
            ToolbarSpacer(.fixed)
        case .flexible:
            ToolbarSpacer(.flexible)
        }
    }

    func toolbarButton(_ symbol: String) -> some View {
        Button {} label: {
            Image(systemName: symbol)
        }
        .accessibilityLabel(symbol)
    }
}

// MARK: - Helpers
private extension GlassToolbarShowroomPage {
    var panelSymbols: [String] {
        ["wand.and.sparkles", "slider.horizontal.3", "paintpalette"]
    }

    var barActions: [String] {
        ["square.and.pencil", "bookmark", "tray.and.arrow.down"]
    }

    /// One shared id merges the chips into a single glass shape; distinct ids
    /// keep them separate.
    func unionID(for symbol: String) -> String {
        configuration.unionsGlassButtons ? "panel" : symbol
    }

    /// The three button styles are different types, so the choice has to branch.
    @ViewBuilder func treated(_ button: some View) -> some View {
        switch configuration.buttonTreatment {
        case .glass:
            button.buttonStyle(.glass)
        case .glassProminent:
            button.buttonStyle(.glassProminent)
        case .borderless:
            button.buttonStyle(.borderless)
        }
    }

    /// `ScrollEdgeEffectStyle` is chosen at the call site rather than stored.
    @ViewBuilder func scrollEdgeStyled(_ scroll: some View) -> some View {
        let edges = configuration.scrollEdgeTarget.edges

        switch configuration.scrollEdge {
        case .automatic:
            scroll.scrollEdgeEffectStyle(.automatic, for: edges)
        case .soft:
            scroll.scrollEdgeEffectStyle(.soft, for: edges)
        case .hard:
            scroll.scrollEdgeEffectStyle(.hard, for: edges)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        GlassToolbarShowroomPage()
    }
}
