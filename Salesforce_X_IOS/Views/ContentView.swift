//
//  ContentView.swift
//  Salesforce_X_IOS
//
//  Created by Shmouel Illouz on 14/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                HeaderView()
                
                Text("Welcome to IOS X SF")
                    .font(.title2)
                    .foregroundColor(.primary)
                
                NavigationLink(destination: FormView()) {
                    HStack {
                        Image(systemName: "person.badge.plus")
                        Text("Create New Client")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .scaleEffect(1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: true)
                }
                .buttonStyle(ScaleButtonStyle())
            }
            .padding()
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
