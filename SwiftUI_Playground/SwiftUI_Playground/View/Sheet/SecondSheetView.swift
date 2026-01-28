//
//  SecondSheetView.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

struct SecondSheetView: View {
    // MARK: - Properties
    @State private var isThirdSheetPresented = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Color.green.opacity(0.3)
                .ignoresSafeArea()
                .overlay {
                    VStack(spacing: 20) {
                        Text("Second Sheet")
                            .font(.largeTitle.bold())

                        Text("Detent: .fraction(0.7)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Button {
                            isThirdSheetPresented = true
                        } label: {
                            Label("Open Third Sheet", systemImage: "chevron.right")
                                .font(.headline)
                                .padding()
                                .background(.green, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .navigationTitle("Second Sheet")
                .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.fraction(0.7)])
        .sheet(isPresented: $isThirdSheetPresented) {
            ThirdSheetView()
        }
    }
}
