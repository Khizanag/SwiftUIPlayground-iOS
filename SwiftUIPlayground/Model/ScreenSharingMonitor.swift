//
//  ScreenSharingMonitor.swift
//  SwiftUIPlayground
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
}

// MARK: - Monitoring

private extension ScreenSharingMonitor {
    func startMonitoring() {
        checkScreenSharingState()

        NotificationCenter.default
            .publisher(for: UIScreen.capturedDidChangeNotification)
            .sink { [weak self] _ in
                self?.checkScreenSharingState()
            }
            .store(in: &cancellables)

        Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkScreenSharingState()
            }
            .store(in: &cancellables)
    }

    func checkScreenSharingState() {
        let screens = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .compactMap { $0.windows.first?.screen }

        isScreenSharing = !screens.isEmpty && screens.contains { $0.isCaptured }
    }
}
