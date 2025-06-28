//
//  ContentView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	
	let container: ModelContainer
	
	init() {
		do {
			container = try ModelContainer(for: SentenceModel.self)
		} catch {
			fatalError("Failed to create model container: \(error.localizedDescription)")
		}
	}
	
    var body: some View {
		MainTabView()
			.modelContainer(container)
    }
}

#Preview {
    ContentView()
}
