//
//  SentenceUserTextfieldView.swift
//  BunGen
//
//  Created by Malte Ruff on 25.06.25.
//

import SwiftUI

struct SentenceUserTextfieldView: View {
	
	@Binding var input: String
	@Binding var aiIsAnswering: Bool
	
	var onSubmitAnswer: (() -> Void)
	
	@State private var pressedButton = false
	
    var body: some View {
		Section {
			Button {
				hideKeyboard()
			} label: {
				Label("Hide keyboard", systemImage: "keyboard.chevron.compact.down.fill")
					.font(.subheadline)
					.frame(width: 24, height: 24)
					.foregroundStyle(.foreground)
					.padding(6)
					.labelStyle(.iconOnly)
					.glassEffect(.regular.interactive(), in: .circle)
			}
			.buttonStyle(.plain)
			
			
			TextField("Answer", text: $input, axis: .vertical)
				.lineLimit(1, reservesSpace: true)			
			
			Button {
				hideKeyboard()
				pressedButton.toggle()
				onSubmitAnswer()
			} label: {
				Image(systemName: pressedButton ? "apple.intelligence" : "paperplane.fill")
					.font(.subheadline)
					.frame(width: 24, height: 24)
					.foregroundStyle(.foreground)
					.contentTransition(.symbolEffect(.replace))
					.symbolEffect(
						.bounce,
						options: pressedButton ? .repeating : .default,
						value: aiIsAnswering
					)
					.onChange(of: pressedButton) { _, newValue in
						aiIsAnswering = newValue
					}
					.padding(6)
					.glassEffect(.regular.interactive(), in: .circle)
			}
		}
		.padding(8)
    }
	
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#Preview {
	Form {
		HStack {
			SentenceUserTextfieldView(
				input: .constant("my answer"),
				aiIsAnswering: .constant(false),
				onSubmitAnswer: { print("Hello")}
			)
		}
		
		HStack {
			SentenceUserTextfieldView(
				input: .constant("my answer"),
				aiIsAnswering: .constant(true),
				onSubmitAnswer: { print("Hello")}
			)
		}
	}
}
