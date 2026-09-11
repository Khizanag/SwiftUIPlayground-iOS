//
//  DemoRoute.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 10.09.26.
//

import SwiftUI

enum DemoRoute: CaseIterable, Identifiable, Hashable {
    case cardScroll
    case cardTransition
    case glassToolbar
    case keyboard
    case sheet

    // MARK: - Properties
    var id: Self { self }

    var title: String {
        switch self {
        case .cardScroll:
            "Card Scroll Demo"
        case .cardTransition:
            "Card Transition Demo"
        case .glassToolbar:
            "Glass Toolbar Showroom"
        case .keyboard:
            "Keyboard Showroom"
        case .sheet:
            "Sheet Showroom"
        }
    }

    var icon: String {
        switch self {
        case .cardScroll:
            "rectangle.stack.fill"
        case .cardTransition:
            "square.on.square.dashed"
        case .glassToolbar:
            "circle.lefthalf.striped.horizontal"
        case .keyboard:
            "keyboard"
        case .sheet:
            "rectangle.stack"
        }
    }

    // MARK: - Methods
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .cardScroll:
            CardScrollViewShowroomPage()
        case .cardTransition:
            CardTransitionShowroomPage()
        case .glassToolbar:
            GlassToolbarShowroomPage()
        case .keyboard:
            KeyboardShowroomPage()
        case .sheet:
            SheetShowroomPage()
        }
    }
}
