//
//  FirstSheetView.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

struct FirstSheetView: View {
    // MARK: - Properties
    @State private var isSecondSheetPresented = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Color.blue.opacity(0.3)
                .ignoresSafeArea()
                .overlay {
                    VStack(spacing: 20) {
                        Text("First Sheet")
                            .font(.largeTitle.bold())

                        Text("Detent: .medium")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Button {
                            isSecondSheetPresented = true
                        } label: {
                            Label("Open Second Sheet", systemImage: "chevron.right")
                                .font(.headline)
                                .padding()
                                .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .navigationTitle("First Sheet")
                .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium])
        .sheet(isPresented: $isSecondSheetPresented) {
            SecondSheetView()
        }
    }
}
