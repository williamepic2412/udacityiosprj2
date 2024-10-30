//
//  eventcountdownApp.swift
//  eventcountdown
//
//  Created by William Epic on 28/10/2024.
//

import SwiftUI

struct Event: Identifiable, Comparable, Hashable {
    var id: UUID
    var title: String
    var date: Date
    var textColor: Color

    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}

@main
struct eventcountdownApp: App {
    var body: some Scene {
        WindowGroup {
            EventsView()
        }
    }
}
