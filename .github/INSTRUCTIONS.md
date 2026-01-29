# Project Instructions

## Overview
SwiftUI Playground - A collection of SwiftUI demos, experiments, and reusable components.

## Requirements
- iOS 26.0+
- Xcode 26.0+
- Swift 6.2+

## Code Style

### File Organization
- Place models in `Model/` folder
- Place views in `View/` folder, grouped by feature (e.g., `View/CardScroll/`, `View/Keyboard/`)
- Place navigation-related code in `Navigation/` folder

### Private Extensions Pattern
- **NEVER** use `private var` or `private func` inside the main struct/class body
- Move all private members to `private extension` blocks below the main declaration
- Organize private extensions by concern with `// MARK: -` comments
- Example structure:
```swift
struct MyView: View {
    // Properties at top (can be private with property wrappers)
    @State private var value = ""

    var body: some View {
        // Main structure only
    }
}

// MARK: - Subviews

private extension MyView {
    var headerSection: some View { ... }
    var contentSection: some View { ... }
}

// MARK: - Helpers

private extension MyView {
    func formatValue() -> String { ... }
}

// MARK: - Actions

private extension MyView {
    func handleTap() { ... }
}
```

### Property Wrappers
- Use custom property wrappers with `@AppStorage` for persistent settings (e.g., `@AppColorScheme`, `@ScreenProtectionEnabled`)
- Default values should be sensible (e.g., screen protection OFF by default)

### SwiftUI Patterns
- Use `// MARK: -` comments to organize code sections
- Extract complex view sections into private computed properties in private extensions
- Use SF Symbols with `.contentTransition(.symbolEffect(.replace))` for animated icon changes
- Apply `.ignoresSafeArea()` when overlays need to cover the entire screen

### Commits
- Use clear, concise commit messages in imperative mood
- Group related changes into logical commits
- No AI attribution in commit messages

## Feature Areas

### Screen Protection
- Controlled via `@ScreenProtectionEnabled` property wrapper
- Uses `ScreenSharingMonitor` to detect screen recording/sharing
- Blur overlay covers entire screen including safe areas when active

### Appearance
- Controlled via `@AppColorScheme` property wrapper
- Supports light, dark, and system modes
- Uses `ColorSchemeOption` enum

### Demos
- Card Scroll: Interactive card-based scrolling
- Keyboard Showroom: Various keyboard interaction patterns
- Sheet Showroom: Sheet presentation with dynamic detents
