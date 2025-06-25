//
//  ContentView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var sentenceViewModel: SentenceViewModel = .init()
	
    var body: some View {
		MainTabView()
			.environmentObject(sentenceViewModel)
    }
}

#Preview {
    ContentView()
}
