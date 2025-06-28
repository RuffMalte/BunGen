//
//  AIProgressView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//
import SwiftUI

struct AIProgressView: View {
	var systemName: String = "apple.intelligence"
	
    var body: some View {
		Image(systemName: systemName)
			.font(.largeTitle)
			.padding()
			.foregroundStyle(.orange.gradient)
			.symbolEffect(.rotate.byLayer, options: .repeat(.periodic(delay: 0.0)))
    }
}
