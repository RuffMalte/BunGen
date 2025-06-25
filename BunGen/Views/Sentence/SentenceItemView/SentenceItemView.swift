//
//  SentenceItemView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import FoundationModels

struct SentenceItemView: View {
	
	var sentence: SentenceModel?
	
	
	@State var answer: String = ""
	@State private var submittedAnswer: Bool = false
	@State private var isAnswering = false
	
	
	@State private var answerWasCorrect: AISentenceResponse?

	@State private var number: Int = 10
	var body: some View {
		if let sentence = sentence {
			SentenceItemHeaderView(sentence: sentence)
				.onAppear {
					answer = ""
					submittedAnswer = false
					isAnswering = false
					answerWasCorrect = nil
				}
			
			
			if let wasCorrect = answerWasCorrect {
				Section {
					HStack {
						Image(systemName: wasCorrect.rating.icon)
							.foregroundStyle(wasCorrect.rating.color)
							.font(.largeTitle)
						
						VStack(alignment: .leading) {
							Text(wasCorrect.rating.asText)
								.font(
									.system(
										.largeTitle,
										design: .rounded,
										weight: .bold
									)
								)
							
							Text(wasCorrect.confidence, format: .number)
								.font(
									.system(
										.footnote,
										design: .monospaced,
										weight: .bold
									)
								)
						}
						Spacer()
					}
					Text(wasCorrect.explanation)
					if let corrected = wasCorrect.corrected {
						Text("Corrected: " + corrected)
					}
					
					VStack {
						ForEach(wasCorrect.suggestions, id: \.self) { sugg in
							Text(sugg)
						}
					}
					
				}
			}
			
			
			Section {
				
				HStack {
					TextField("English Answer", text: $answer)
					Button {
						hideKeyboard()
						
						if answerWasCorrect == nil && answer.isEmpty {
							return
						}
						
						withAnimation {
							submittedAnswer = true
							isAnswering = true
							answerWasCorrect = nil
							//								answer = ""
						}
						let intructions: String = """
							You are a Japanese learning instructor, this is the sentence the user was presented: '\(sentence.japanese)'. Your job is to look if the answer is correct, you can be lenient and allow answers that are logically right but are not exactly the answer: '\(sentence.english)'.
							"""
						
						let prompt: String = "Please check this answer: '\(answer)'."
						
						
						let session = LanguageModelSession(
							instructions: intructions
						)
						Task {
							answerWasCorrect = try? await session.respond(
								to: prompt,
								generating: AISentenceResponse.self
							).content
							
							withAnimation {
								submittedAnswer = false
								isAnswering = true
							}
						}
						
					} label: {
						Image(systemName: submittedAnswer ? "apple.intelligence" : "paperplane.fill")
							.font(.body)
							.frame(width: 24, height: 24)
							.foregroundStyle(.foreground)
							.contentTransition(.symbolEffect(.replace))
							.symbolEffect(
								.bounce,
								options: submittedAnswer ? .repeating : .default,
								value: isAnswering
							)
							.onChange(of: submittedAnswer) { _, newValue in
								isAnswering = newValue
							}
							.padding(5)
							.glassEffect(.regular.interactive())
					}
					.disabled(isAnswering)
				}
			}
			
		} else {
			ContentUnavailableView("None", systemImage: "square.dashed")
		}
		
	}
    
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#Preview {
	Form {
		SentenceItemView(sentence: SentenceModel.samples.first)
	}
}
