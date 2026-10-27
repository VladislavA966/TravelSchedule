//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Владилсав on 27/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await NetworkDemo.runAll()
        }
    }
}

#Preview {
    ContentView()
}
