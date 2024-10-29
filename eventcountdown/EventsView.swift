//
//  EventsView.swift
//  eventcountdown
//
//  Created by William Epic on 29/10/2024.
//

import SwiftUI

struct EventsView: View {
    @State private var events: [Event] = [] // Your array of events
    @State private var showingEventForm = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(events.sorted()) { event in
                    NavigationLink(destination: EventForm(mode:.edit(event), onSave: { updatedEvent in
                        // Update the event in the array
                        if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                            events[index] = updatedEvent
                        }
                    })) {
                        EventRow(event: event)
                    }
                }
                .onDelete(perform: deleteEvent)
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingEventForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingEventForm) {
                EventForm(mode:.add, onSave: { newEvent in
                    events.append(newEvent) // Add the new event to the array
                    showingEventForm = false
                })
            }
        }
    }

    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}


#Preview {
    EventsView()
}
