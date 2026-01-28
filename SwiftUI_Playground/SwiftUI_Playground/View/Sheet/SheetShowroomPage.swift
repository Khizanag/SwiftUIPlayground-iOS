//
//  SheetShowroomPage.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 28.01.26.
//

import SwiftUI

struct SheetShowroomPage: View {
    @State private var isSheetPresented = false

    var body: some View {
        List {
            Section {
                descriptionCard
            }

            Section {
                sheetChainInfo
            } header: {
                Text("Sheet Chain Demo")
            } footer: {
                Text("Demonstrates nested sheets with different presentation detents.")
            }
        }
        .navigationTitle("Sheet Showroom")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .safeAreaInset(edge: .bottom) {
            openSheetButton
        }
        .sheet(isPresented: $isSheetPresented) {
            FirstSheetView()
        }
    }
}

// MARK: - Subviews

private extension SheetShowroomPage {
    var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("About", systemImage: "info.circle.fill")
                .font(.subheadline.bold())
                .foregroundStyle(.blue)

            Text("This demo shows how to chain multiple sheets together, each with different presentation detents. Tap the button below to start the chain.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }

    var sheetChainInfo: some View {
        VStack(spacing: 0) {
            sheetInfoRow(
                number: 1,
                title: "First Sheet",
                detent: ".medium",
                color: .blue
            )

            chainArrow

            sheetInfoRow(
                number: 2,
                title: "Second Sheet",
                detent: ".fraction(0.7)",
                color: .green
            )

            chainArrow

            sheetInfoRow(
                number: 3,
                title: "Third Sheet",
                detent: ".large",
                color: .purple,
                isLast: true
            )
        }
    }

    func sheetInfoRow(
        number: Int,
        title: String,
        detent: String,
        color: Color,
        isLast: Bool = false
    ) -> some View {
        HStack(spacing: 12) {
            Text("\(number)")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(color, in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.medium))

                Text("Detent: \(detent)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if isLast {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(color)
            } else {
                Image(systemName: "arrow.right.circle")
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }

    var chainArrow: some View {
        HStack {
            Rectangle()
                .fill(.secondary.opacity(0.3))
                .frame(width: 2, height: 20)
                .padding(.leading, 13)

            Spacer()
        }
    }

    var openSheetButton: some View {
        VStack(spacing: 0) {
            Divider()

            Button {
                isSheetPresented = true
            } label: {
                Label("Start Sheet Chain", systemImage: "rectangle.stack")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(.ultraThinMaterial)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SheetShowroomPage()
    }
}
