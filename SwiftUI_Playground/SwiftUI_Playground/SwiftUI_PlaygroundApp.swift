//
//  SwiftUI_PlaygroundApp.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

@main
struct SwiftUI_PlaygroundApp: App {
    // MARK: - Properties
    @AppColorScheme private var colorScheme
    @State private var screenSharingMonitor = ScreenSharingMonitor()
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(screenSharingMonitor)
//                .screenSharingBlur(isScreenSharing: $screenSharingMonitor.isScreenSharing)
                .preferredColorScheme(colorScheme.colorScheme)
        }
    }
}
