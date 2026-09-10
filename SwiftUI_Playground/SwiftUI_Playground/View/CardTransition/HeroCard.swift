//
//  HeroCard.swift
//  SwiftUI_Playground
//
//  Created by Giga Khizanishvili on 10.09.26.
//

import SwiftUI

struct HeroCard: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let tagline: String
    let story: String
    let highlights: [String]
    let stats: [Stat]
    let icon: String
    let tint: Color
    let accent: Color
}

// MARK: - Stat
extension HeroCard {
    struct Stat: Identifiable, Hashable {
        let id = UUID()
        let label: String
        let value: String
    }
}

// MARK: - Sample Data
extension HeroCard {
    static let samples: [HeroCard] = [
        HeroCard(
            title: "Aurora",
            subtitle: "Northern Lights",
            tagline: "Solar wind, painted across the sky",
            story: """
                Charged particles from the sun collide with the upper atmosphere and release \
                light. Green comes from oxygen at low altitude, red from oxygen far higher up, \
                and the rare blue edge from nitrogen.
                """,
            highlights: [
                "Best viewed between September and March",
                "Peaks around magnetic midnight",
                "Follows the eleven-year solar cycle",
                "Visible from both magnetic poles",
            ],
            stats: [
                Stat(label: "Altitude", value: "100 km"),
                Stat(label: "Season", value: "Winter"),
                Stat(label: "Kp index", value: "5+"),
            ],
            icon: "sparkles",
            tint: .indigo,
            accent: .purple
        ),
        HeroCard(
            title: "Tide Pool",
            subtitle: "Coastal Life",
            tagline: "An ocean small enough to kneel beside",
            story: """
                Twice a day the sea withdraws and leaves behind a closed world. Everything in it \
                survives six hours of heat, then six hours of cold surf, and does so on a schedule \
                set by the moon.
                """,
            highlights: [
                "Anemones close to hold their water",
                "Hermit crabs trade shells as they grow",
                "Sea stars pry open mussels for hours",
                "Zonation stacks species by exposure",
            ],
            stats: [
                Stat(label: "Cycle", value: "12h 25m"),
                Stat(label: "Species", value: "40+"),
                Stat(label: "Depth", value: "0.3 m"),
            ],
            icon: "water.waves",
            tint: .teal,
            accent: .cyan
        ),
        HeroCard(
            title: "Ember",
            subtitle: "Desert Nights",
            tagline: "Heat the ground gives back after dark",
            story: """
                Sand holds almost no water, so it sheds the day's warmth as soon as the sun drops. \
                The swing between noon and midnight can cross forty degrees, and every living \
                thing out there is built around it.
                """,
            highlights: [
                "Most animals move only at night",
                "Cacti open their pores after sunset",
                "Radiative cooling can reach freezing",
                "Dew becomes the main water source",
            ],
            stats: [
                Stat(label: "Swing", value: "40 °C"),
                Stat(label: "Rain", value: "25 mm"),
                Stat(label: "Humidity", value: "12%"),
            ],
            icon: "flame.fill",
            tint: .orange,
            accent: .red
        ),
        HeroCard(
            title: "Canopy",
            subtitle: "Rainforest",
            tagline: "A second forest floor, sixty metres up",
            story: """
                Most rainforest life never touches the ground. The canopy catches the light, the \
                rain and the wind, and holds an ecosystem with its own soil, its own ponds and its \
                own animals that are born and die up there.
                """,
            highlights: [
                "Holds half of all land species",
                "Epiphytes grow soil on bare branches",
                "Bromeliad pools raise entire frog broods",
                "Light drops 98% before the forest floor",
            ],
            stats: [
                Stat(label: "Height", value: "60 m"),
                Stat(label: "Rain", value: "2.5 m/yr"),
                Stat(label: "Species", value: "50%"),
            ],
            icon: "leaf.fill",
            tint: .green,
            accent: .mint
        ),
        HeroCard(
            title: "Summit",
            subtitle: "Alpine Routes",
            tagline: "Thin air and a very short window",
            story: """
                Above eight thousand metres the body consumes itself faster than it can recover. \
                Weather windows open for a day or two at a time, and the whole expedition is \
                arranged around being in position when one does.
                """,
            highlights: [
                "Oxygen is a third of sea level",
                "Acclimatisation takes several weeks",
                "Windows last 24 to 48 hours",
                "Descent causes most accidents",
            ],
            stats: [
                Stat(label: "Altitude", value: "8 km"),
                Stat(label: "Oxygen", value: "33%"),
                Stat(label: "Window", value: "48h"),
            ],
            icon: "mountain.2.fill",
            tint: .blue,
            accent: .indigo
        ),
        HeroCard(
            title: "Dune",
            subtitle: "Sand Seas",
            tagline: "Landscape that moves while you watch it",
            story: """
                A dune is wind made visible. Sand climbs the shallow windward face, spills over the \
                crest and settles at the angle it can just hold, so the whole ridge walks downwind \
                a few metres every year.
                """,
            highlights: [
                "Slip face rests at 34 degrees",
                "Ridges migrate up to 20 m a year",
                "Grain avalanches make dunes boom",
                "Shape records the prevailing wind",
            ],
            stats: [
                Stat(label: "Slip face", value: "34°"),
                Stat(label: "Drift", value: "20 m/yr"),
                Stat(label: "Grain", value: "0.3 mm"),
            ],
            icon: "sun.max.fill",
            tint: .yellow,
            accent: .orange
        ),
    ]
}
