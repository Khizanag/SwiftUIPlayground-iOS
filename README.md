# SwiftUI Playground

A collection of SwiftUI demos, experiments, and reusable components showcasing what's possible with Apple's declarative UI framework.

## Overview

This repository serves as a playground for exploring SwiftUI capabilities, demonstrating various UI patterns, animations, and techniques. Each demo is self-contained and can be used as a reference or starting point for your own projects.

## Demos

Each demo is one scene, opened from the list on launch. They are independent —
read one without reading the others.

| Scene | Kind of example | What it demonstrates |
|---|---|---|
| Card Transition | Navigation animation | A card that morphs into a full page and back |
| Card Scroll | Gesture-driven layout | A snap scroller built from a drag gesture |
| Keyboard Showroom | Keyboard and focus | Four ways to swap the keyboard of a focused field |
| Sheet Showroom | Presentation | Sheets chained on top of one another |

### Card Transition

A grid of cards; tapping one pushes a detail page that grows out of the card
itself, and Back reverses the morph.

- `matchedTransitionSource(id:in:)` on the source card, paired with
  `.navigationTransition(.zoom(sourceID:in:))` on the pushed page.
- The push runs through `Navigator`, not a `NavigationLink` — the zoom binds to
  the transition source and the destination's `sourceID`, so how the value
  reaches the path does not matter.
- The page is built only when pushed, so it registers its destination and its
  `@Namespace` once. Build it eagerly and the zoom degrades to a slide.
- The detail page wears the card's gradient full bleed, with content on
  translucent surfaces, so the morph lands on continuous colour.
- The card's label sits where the detail hero's does, at the same corner in the
  same order, so the zoom grows one into the other instead of crossing two apart.
- A short press dim on the card that settles before the push, with Reduce Motion
  and Reduce Transparency fallbacks. The zoom is the only motion on the page — nothing else animates in
  behind it.

### Card Scroll

A stack of cards with differing heights that snap into place as you drag.

- A `DragGesture` and its end velocity drive the index, instead of `ScrollView`
  paging.
- Cards trail behind with a parallax offset and settle on a spring.

### Keyboard Showroom

The same problem — swapping the keyboard under a focused field — solved four
ways, side by side.

- A timer-driven refocus with a native animation.
- A UIKit wrapper carrying its own transition.
- A 123/ABC toolbar above the keyboard.
- Native detection of the numeric layout, with no extra UI.

### Sheet Showroom

Sheets presented on top of one another, each step declaring its own
`presentationDetents`, so the stack grows and shrinks as it opens and closes.

### App-level behaviour

- **Dynamic colour scheme**: light, dark, or system appearance.
- **Screen sharing detection**: blurs content while the screen is recorded or
  shared.
- **Custom navigation**: a navigation stack that tracks presentation detents.

## Requirements

- iOS 26.0+
- Xcode 26.0+
- Swift 6.2+

## Getting Started

1. Clone the repository
2. Open `SwiftUIPlayground.xcodeproj`
3. Build and run on simulator or device

## Project Structure

```
SwiftUIPlayground/
├── Model/                 # Data models and utilities
├── Navigation/            # Custom navigation system
└── View/
    ├── CardScroll/        # Card scrolling demo
    ├── CardTransition/    # Card to page zoom transition demo
    ├── Keyboard/          # Keyboard interaction demos
    └── Sheet/             # Sheet presentation demo
```

## License

This project is available for learning and reference purposes.