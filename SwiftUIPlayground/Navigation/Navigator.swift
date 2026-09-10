//
//  Navigator.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

/// Drives the app's navigation stack, so any screen can push without owning the
/// stack or reaching for a `NavigationLink`.
///
/// The path is heterogeneous: each screen registers `navigationDestination(for:)`
/// for the values it knows how to present, and pushes those values by type.
@MainActor
@Observable
final class Navigator {
    // MARK: - Properties
    var path = NavigationPath()

    // MARK: - Methods
    func push(_ destination: some Hashable) {
        path.append(destination)
    }

    func pop() {
        guard !path.isEmpty else { return }

        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
