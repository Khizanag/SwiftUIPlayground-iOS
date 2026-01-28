//
//  NavigationView.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

struct NavigationView<Root: View>: View {
    // MARK: - Properties
    private let navigator: Navigator
    private let root: () -> Root
    @State private var animatedSelectedDetent: PresentationDetent

    // MARK: - Init
    /// Creates a navigation stack that manages its own navigation state.
    ///
    /// - Parameters:
    ///   - root: The view to display when the stack is empty.
    @MainActor @preconcurrency init(navigator: Navigator, @ViewBuilder root: @escaping () -> Root) {
        self.navigator = navigator
        self.root = root
        _animatedSelectedDetent = State(initialValue: navigator.selectedPresentationDetent)
    }

    // MARK: - Computed Properties
    private var selectedDetentBinding: Binding<PresentationDetent> {
        Binding(
            get: { animatedSelectedDetent },
            set: { newValue in
                withAnimation(.easeInOut) {
                    animatedSelectedDetent = newValue
                    navigator.selectedPresentationDetent = newValue
                }
            }
        )
    }

    // MARK: - Body
    var body: some View {
        NavigationStack(path: Bindable(navigator).path) {
            root()
                .navigationDestination(for: NavigationDestination.self) {
                    $0.view()
                }
        }
        .onChange(of: navigator.selectedPresentationDetent) { oldValue, newValue in
            withAnimation(.easeInOut) {
                animatedSelectedDetent = newValue
            }
        }
        .presentationDetents(
            NavigationDestination.allPresentationDetents,
            selection: selectedDetentBinding
        )
        .environment(navigator)
        .presentationBackground(content: { Color.orange } )
    }
}