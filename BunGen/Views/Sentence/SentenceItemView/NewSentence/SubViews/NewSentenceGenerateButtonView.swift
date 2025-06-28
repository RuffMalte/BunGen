//
//  NewSentenceGenerateButtonView.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI

struct NewSentenceGenerateButtonView: View {
	
	@Binding var isAnswering: Bool
	var onPress: () -> Void
	
    var body: some View {
		Button(role: .confirm) {
			onPress()
		} label: {
			Image(systemName: isAnswering ? "apple.intelligence" : "apple.intelligence")
				.contentTransition(.symbolEffect(.replace))
				.symbolEffect(
					.bounce,
					options: isAnswering ? .repeating : .default,
					value: isAnswering
				)
				.onChange(of: isAnswering) { _, newValue in
					isAnswering = newValue
				}
			
		}
		.disabled(isAnswering)
    }
}

#Preview {
	NewSentenceGenerateButtonView(isAnswering: .constant(true), onPress: {print("Pressed")})
}
