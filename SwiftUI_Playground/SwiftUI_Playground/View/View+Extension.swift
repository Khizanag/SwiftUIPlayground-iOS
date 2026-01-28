//
//  View+Extension.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 07.11.25.
//

import SwiftUI

// MARK: - Conditional View Modifier
extension View {
    @ViewBuilder
    func ifLet<Value, Content: View>(
        _ optional: Value?,
        transform: (Self, Value) -> Content
    ) -> some View {
        if let value = optional {
            transform(self, value)
        } else {
            self
        }
    }
}
