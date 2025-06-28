//
//  SentenceItemView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import FoundationModels

struct SentenceItemView: View {
	
	@Binding var sentence: SentenceModel?
	var onGenerateNewSentenceWithSameParameters: () -> Void
	
	@State var answer: String = ""
	@State private var submittedAnswer: Bool = false
	@State private var isAnswering = false
	
	
	@State private var answerWasCorrect: AISentenceResponse?
	@State private var pressedButton = false

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

						if answerWasCorrect != nil {
							ToolbarSpacer(.flexible, placement: .bottomBar)

							ToolbarItem(placement: .bottomBar) {
								Button(role: .confirm) {
									withAnimation {
										self.sentence = nil
									}
									
								} label: {
									Image(systemName: "arrow.trianglehead.2.clockwise")
								}
							}
//							ToolbarSpacer(.flexible, placement: .bottomBar)

							ToolbarItem(placement: .bottomBar) {
								Button(role: .confirm) {
									withAnimation {
										self.sentence = nil
										onGenerateNewSentenceWithSameParameters()
									}
									
								} label: {
									Image(systemName: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath")
								}
							}
						
						} else {
							ToolbarItem(placement: .bottomBar) {
								Button {
									hideKeyboard()
								} label: {
									Label("Hide keyboard", systemImage: "keyboard.chevron.compact.down.fill")
										.labelStyle(.iconOnly)
								}
							}
							ToolbarSpacer(.flexible, placement: .bottomBar)
							
							ToolbarItem(placement: .bottomBar) {
								TextField("Your Answer that will be graded", text: $answer, axis: .vertical)
									.lineLimit(1, reservesSpace: true)
									.textFieldStyle(.plain)
									.padding(.horizontal, 6)
							}
							ToolbarSpacer(.flexible, placement: .bottomBar)
							
							ToolbarItem(placement: .bottomBar) {
								Button(role: .confirm) {
									hideKeyboard()
									pressedButton.toggle()
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
									Image(systemName: pressedButton ? "apple.intelligence" : "paperplane.fill")
										.contentTransition(.symbolEffect(.replace))
										.symbolEffect(
											.bounce,
											options: pressedButton ? .repeating : .default,
											value: isAnswering
										)
										.onChange(of: pressedButton) { _, newValue in
											isAnswering = newValue
										}
								}
								
							}
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
			SentenceItemView(
				sentence: .constant(SentenceModel.samples.first),
				onGenerateNewSentenceWithSameParameters: {}
			)
		}
	}
}
