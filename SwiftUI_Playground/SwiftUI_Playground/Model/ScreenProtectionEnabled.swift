//
//  ScreenProtectionEnabled.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 28.01.26.
//

import SwiftUI

@propertyWrapper
struct ScreenProtectionEnabled: DynamicProperty {
    @AppStorage("screenProtectionEnabled") private var storedValue: Bool = false

    var wrappedValue: Bool {
        get { storedValue }
        nonmutating set { storedValue = newValue }
    }

    var projectedValue: Binding<Bool> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
}
