//
//  SwiftUIPlaygroundApp.swift
//  SwiftUIPlayground
//
//  Created by Giga Khizanishvili on 06.11.25.
//

import SwiftUI

@main
struct SwiftUIPlaygroundApp: App {
    // MARK: - Properties
    @AppColorScheme private var colorScheme
    @ScreenProtectionEnabled private var screenProtectionEnabled
    @State private var screenSharingMonitor = ScreenSharingMonitor()

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(screenSharingMonitor)
                .screenSharingBlur(
                    isScreenSharing: screenProtectionEnabled && screenSharingMonitor.isScreenSharing
                )
                .preferredColorScheme(colorScheme.colorScheme)
        }
    }
}
