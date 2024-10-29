//
//  EventForm.swift
//  eventcountdown
//
//  Created by William Epic on 29/10/2024.
//

import SwiftUI

struct EventForm: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var textColor: Color = .black
    var mode: Mode
    var onSave: (Event) -> Void

    enum Mode {
        case add
        case edit(Event)
    }

    init(mode: Mode, onSave: @escaping (Event) -> Void) {
        self.mode = mode
        self.onSave = onSave
        
        if case .edit(let event) = mode {
            _title = State(initialValue: event.title)
            _date = State(initialValue: event.date)
            _textColor = State(initialValue: event.textColor)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                        .foregroundColor(textColor)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    
                    ColorPicker("Text Color", selection: $textColor)
                }
            }
            .navigationTitle(modeTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveEvent()
                    }
                }
            }
        }
    }

    private var modeTitle: String {
        switch mode {
        case .add:
            return "Add Event"
        case .edit(let event):
            return "Edit \(event.title)"
        }
    }

    private func saveEvent() {
        guard !title.isEmpty else { return } // Ensure title is not empty
        
        let newEvent = Event(id: UUID(), title: title, date: date, textColor: textColor)
        onSave(newEvent)
        dismiss()
    }
}
