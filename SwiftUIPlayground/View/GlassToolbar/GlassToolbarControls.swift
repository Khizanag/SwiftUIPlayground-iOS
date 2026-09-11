//
//  GlassToolbarControls.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 11.09.26.
//

import SwiftUI

/// The control panel for `GlassToolbarShowroomPage`, grouped by the part of the
/// chrome each knob rewrites.
struct GlassToolbarControls: View {
    // MARK: - Properties
    @Binding var configuration: GlassToolbarConfiguration

    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            toolbarSection
            chromeSection
            scrollEdgeSection
            glassSection
        }
    }
}

// MARK: - Sections
private extension GlassToolbarControls {
    var toolbarSection: some View {
        section("Toolbar content") {
            Toggle("ToolbarSpacer", isOn: $configuration.usesSpacer)

            if configuration.usesSpacer {
                picker("Spacer sizing", selection: $configuration.spacerSizing, label: \.label)
            }

            Toggle("Group shares background", isOn: $configuration.groupSharesBackground)
            picker("Button style", selection: $configuration.buttonTreatment, label: \.label)
            picker("Tint", selection: $configuration.tint, label: \.label)
        }
    }

    var chromeSection: some View {
        section("Bar chrome") {
            picker("Background", selection: $configuration.barBackground, label: \.label)
            picker("Colour scheme", selection: $configuration.barColorScheme, label: \.label)
            picker("Title display", selection: $configuration.titleDisplay, label: \.label)
            Toggle("Subtitle", isOn: $configuration.showsSubtitle)
            picker("Role", selection: $configuration.role, label: \.label)
        }
    }

    var scrollEdgeSection: some View {
        section("Scroll edge effect") {
            picker("Style", selection: $configuration.scrollEdge, label: \.label)
            picker("Edges", selection: $configuration.scrollEdgeTarget, label: \.label)
        }
    }

    var glassSection: some View {
        section("Glass surfaces") {
            picker("Variant", selection: $configuration.glassVariant, label: \.label)
            Toggle("Interactive", isOn: $configuration.isGlassInteractive)
            Toggle("Union into one shape", isOn: $configuration.unionsGlassButtons)
            Toggle("Bottom bar", isOn: $configuration.showsBottomBar)
            Toggle("Extend header background", isOn: $configuration.extendsHeaderBackground)
        }
    }
}

// MARK: - Building blocks
private extension GlassToolbarControls {
    func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)

            content()
                .font(.subheadline)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background.secondary, in: .rect(cornerRadius: 20))
    }

    func picker<Option>(
        _ title: String,
        selection: Binding<Option>,
        label: KeyPath<Option, String>
    ) -> some View where Option: CaseIterable & Identifiable & Hashable, Option.AllCases: RandomAccessCollection {
        HStack {
            Text(title)

            Spacer(minLength: 12)

            Picker(title, selection: selection) {
                ForEach(Option.allCases) { option in
                    Text(option[keyPath: label]).tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var configuration = GlassToolbarConfiguration()

    ScrollView {
        GlassToolbarControls(configuration: $configuration)
            .padding(20)
    }
}
