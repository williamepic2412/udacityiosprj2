//
//  EventRow.swift
//  eventcountdown
//
//  Created by William Epic on 29/10/2024.
//

import SwiftUI

struct EventRow: View {
    var event: Event
    @State private var timeRemaining: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.headline)
                .foregroundColor(event.textColor)
            
            Text(timeRemaining)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .onAppear {
            updateCountdown()
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private func updateCountdown() {
        let formatter = RelativeDateTimeFormatter()
        let now = Date()
        timeRemaining = formatter.localizedString(for: event.date, relativeTo: now)
    }

    @State private var timer: Timer?
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateCountdown()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension Event {
    static let testEvent = Event(
        id: UUID(),
        title: "Vist a friend",
        date: Date(),
        textColor: .blue
    )
}

#Preview {
    EventRow(event: Event.testEvent)
}
