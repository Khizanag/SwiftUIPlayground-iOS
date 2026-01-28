//
//  CardItem.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 09.01.26.
//

import SwiftUI

struct CardItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let description: String
    let bulletPoints: [String]
    let color: Color
    let height: CGFloat
    let icon: String
}

// MARK: - Sample Data
extension CardItem {
    static let samples: [CardItem] = [
        CardItem(
            title: "Welcome",
            subtitle: "Getting Started",
            description: "This is the first card in our collection. Swipe up to see more cards. Each card snaps to the top position automatically.",
            bulletPoints: [
                "Swipe up to go to next card",
                "Swipe down to go back",
                "Cards snap into place automatically",
                "Each card has a unique height"
            ],
            color: .blue,
            height: 420,
            icon: "hand.wave.fill"
        ),
        CardItem(
            title: "Features",
            subtitle: "What's Included",
            description: "Explore all the amazing features we have to offer. This card demonstrates the variable height capability of the snap scrolling system.",
            bulletPoints: [
                "Custom gesture-based scrolling",
                "Spring animations for smooth transitions",
                "iOS 16.4+ compatibility",
                "Fully customizable cards",
                "Visual indicators for current position"
            ],
            color: .purple,
            height: 480,
            icon: "star.fill"
        ),
        CardItem(
            title: "Quick Tips",
            subtitle: "Pro Advice",
            description: "Here are some helpful tips to get the most out of this interface.",
            bulletPoints: [
                "Faster swipes trigger quicker transitions",
                "Cards stack with a parallax effect"
            ],
            color: .orange,
            height: 350,
            icon: "lightbulb.fill"
        ),
        CardItem(
            title: "Statistics",
            subtitle: "Your Progress",
            description: "Track your achievements and see how far you've come. This card shows your stats at a glance with detailed breakdowns.",
            bulletPoints: [
                "Daily active usage tracking",
                "Weekly progress reports",
                "Monthly achievement badges",
                "Lifetime statistics overview"
            ],
            color: .green,
            height: 440,
            icon: "chart.bar.fill"
        ),
        CardItem(
            title: "Settings",
            subtitle: "Customize Experience",
            description: "Personalize everything to your liking. Adjust themes, notifications, and more to make the app truly yours.",
            bulletPoints: [
                "Theme customization options",
                "Notification preferences",
                "Privacy and security settings",
                "Data export capabilities",
                "Account management",
                "Accessibility features"
            ],
            color: .red,
            height: 520,
            icon: "gearshape.fill"
        ),
        CardItem(
            title: "Final Card",
            subtitle: "The End",
            description: "You've reached the last card in this collection. Swipe down to navigate back through the previous cards.",
            bulletPoints: [
                "Thanks for exploring!",
                "Swipe down to go back"
            ],
            color: .teal,
            height: 360,
            icon: "checkmark.circle.fill"
        )
    ]
}
