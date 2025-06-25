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
		Group {
			if let sentence = sentence {
				SentenceItemHeaderView(sentence: sentence)
					.onAppear {
						answer = ""
						submittedAnswer = false
						isAnswering = false
						answerWasCorrect = nil
					}
					.toolbar {
						ToolbarItem(placement: .bottomBar) {
							SentenceUserTextfieldView(
								input: $answer,
								aiIsAnswering: $isAnswering,
								onSubmitAnswer: {
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
								}
							)
							
						}
					}
				
				if let wasCorrect = answerWasCorrect {
					SentenceFeedbackView(aiSentenceReport: wasCorrect)
				}
			} else {
				ContentUnavailableView("None", systemImage: "square.dashed")
			}
		}

	}

}

#Preview {
	NavigationStack {
		Form {
			SentenceItemView(sentence: SentenceModel.samples.first)
		}
	}
}
