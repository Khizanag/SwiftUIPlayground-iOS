//
//  ScreenSharingMonitor.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 07.11.25.
//

import SwiftUI
import Combine
import UIKit

@MainActor
@Observable
final class ScreenSharingMonitor {
    // MARK: - Properties
    var isScreenSharing: Bool = false {
        didSet {
            if isScreenSharing != oldValue {
                print("Screen sharing state changed: \(isScreenSharing)")
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        startMonitoring()
    }
    
    // MARK: - Methods
    private func startMonitoring() {
        // Check initial state
        checkScreenSharingState()
        
        // Monitor for changes using NotificationCenter
        NotificationCenter.default
            .publisher(
                for: UIScreen.capturedDidChangeNotification
            )
            .sink { [weak self] s in
                self?.checkScreenSharingState()
                print("Got notification")
            }
            .store(in: &cancellables)
        
        // Also poll periodically as a backup (some cases might not trigger notification)
        let timer = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkScreenSharingState()
            }
        timer.store(in: &cancellables)
    }
    
    private func checkScreenSharingState() {
        // Get screen from connected window scenes (iOS 26.0+ recommended approach)
        let screens = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .compactMap { $0.windows.first?.screen }
        
        // Check if any screen is being captured
        // Fallback to false if no screens are found
        let newState = screens.isEmpty ? false : screens.contains { $0.isCaptured }
        
//        if newState != isScreenSharing {
            isScreenSharing = newState
//        }
    }
    
//    deinit {
//        cancellables.removeAll()
//    }
}

