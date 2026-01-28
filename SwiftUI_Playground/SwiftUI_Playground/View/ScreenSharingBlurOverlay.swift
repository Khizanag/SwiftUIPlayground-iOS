//
//  ScreenSharingBlurOverlay.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 07.11.25.
//

import SwiftUI

struct ScreenSharingBlurOverlay: ViewModifier {
    // MARK: - Properties
    var isScreenSharing: Bool

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .center) {
                if isScreenSharing {
                    GeometryReader { geometry in
                        ZStack {
                            // Strong blur background covering entire screen including edges
                            Rectangle()
                                .fill(.regularMaterial)
                                .background(
                                    Rectangle()
                                        .fill(Color.black.opacity(0.4))
                                )
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .ignoresSafeArea(.all)
                            
                            // Content overlay
                            VStack(spacing: 20) {
                                // Icon
                                Image(systemName: "eye.slash.fill")
                                    .font(.system(size: 60))
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 5)
                                
                                // Message
                                VStack(spacing: 8) {
                                    Text("Screen Sharing Detected")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    Text("This content is protected and cannot be shared")
                                        .font(.subheadline)
                                        .foregroundStyle(.white.opacity(0.9))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 40)
                                }
                                .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 5)
                            }
                            .padding(40)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.thickMaterial)
                                    .shadow(color: .black.opacity(0.3), radius: 25, x: 0, y: 10)
                            )
                            .padding(40)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isScreenSharing)
                    .allowsHitTesting(false) // Allow touches to pass through when not needed
                }
            }
    }
}

// MARK: - View Extension
extension View {
    func screenSharingBlur(isScreenSharing: Bool) -> some View {
        modifier(ScreenSharingBlurOverlay(isScreenSharing: isScreenSharing))
    }
}

