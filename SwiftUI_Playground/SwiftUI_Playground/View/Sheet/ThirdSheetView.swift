//
//  ThirdSheetView.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

struct ThirdSheetView: View {
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Color.purple.opacity(0.3)
                .ignoresSafeArea()
                .overlay {
                    VStack(spacing: 20) {
                        Text("Third Sheet")
                            .font(.largeTitle.bold())

                        Text("Detent: .large")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.purple)

                        Text("End of the chain!")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle("Third Sheet")
                .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.large])
    }
}

