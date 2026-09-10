//
//  AppColorScheme.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

@propertyWrapper
struct AppColorScheme: DynamicProperty {
    @AppStorage("selectedColorScheme") private var storedValue: ColorSchemeOption = .system

    var wrappedValue: ColorSchemeOption {
        get { storedValue }
        nonmutating set { storedValue = newValue }
    }

    var projectedValue: Binding<ColorSchemeOption> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    var colorScheme: ColorScheme? {
        wrappedValue.colorScheme
    }
}
