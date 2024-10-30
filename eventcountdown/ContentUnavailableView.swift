//
//  ContentUnavailableView.swift
//  eventcountdown
//
//  Created by William Epic on 30/10/2024.
//

import SwiftUI

struct ContentUnavailableView: View {
    var onAddEvent: () -> Void
    @State var isPressed = false

    var body: some View {
        VStack {
            Text("No Events Available")
                .font(.headline)
                .foregroundColor(.gray)
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text("It looks like you don't have any events yet.")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Add an event")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .scaleEffect(isPressed ? 1.2 : 1.0)
                .animation(.easeOut(duration: 0.2), value: isPressed)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged {
                            _ in isPressed = true
                            onAddEvent()
                        }
                        .onEnded {
                            _ in isPressed = false
                        }
                )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}
