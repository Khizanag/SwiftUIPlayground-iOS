//
//  NavigationDestination.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

enum NavigationDestination: Hashable {
    case firstSheetView
    case secondSheetView
    case third

    // MARK: - Properties
    static var allPresentationDetents: Set<PresentationDetent> {
        [.fraction(0.3), .fraction(0.5), .fraction(0.7)]
    }

    var selectedPresentationDetent: PresentationDetent {
        switch self {
        case .firstSheetView:
            .fraction(0.3)
        case .secondSheetView:
            .fraction(0.5)
        case .third:
            .fraction(0.7)
        }
    }

    // MARK: - Methods
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .firstSheetView:
            FirstSheetView()
        case .secondSheetView:
            SecondSheetView()
        case .third:
            ThirdSheetView()
        }
    }
}

