//
//  Navigator.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI
import Observation

@Observable
final class Navigator {
    // MARK: - Properties
    let name: String?

    var selectedPresentationDetent: PresentationDetent

    var path: [NavigationDestination] = [] {
        didSet {
            print("Name: \(name, default: "Unnamed") - Path: \(path)")
            let newSelectedDetent = if let last = path.last {
                last.selectedPresentationDetent
            } else {
                rootViewSelectedDetent
            }
            
            if selectedPresentationDetent != newSelectedDetent {
                withAnimation(.easeInOut) {
                    selectedPresentationDetent = newSelectedDetent
                }
            }
        }
    }

    let rootViewSelectedDetent: PresentationDetent

    // MARK: - Init
    init(
        name: String? = nil,
        rootViewSelectedDetent: PresentationDetent
    ) {
        self.name = name
        self.rootViewSelectedDetent = rootViewSelectedDetent
        self.selectedPresentationDetent = rootViewSelectedDetent
    }

    // MARK: - Methods
    func push(_ destination: NavigationDestination) {
        withAnimation(.easeInOut) {
            selectedPresentationDetent = destination.selectedPresentationDetent
            path.append(destination)
        }
    }
}

