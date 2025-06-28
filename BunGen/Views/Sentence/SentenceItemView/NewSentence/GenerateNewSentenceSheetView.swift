//
//  GenerateNewSentenceSheetView.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI
import FoundationModels

struct GenerateNewSentenceSheetView: View {
	
	@State var sentence: SentenceModel?
	
	@State private var isAnswering = false
	
	@State var selectedDifficulty: jlptLevelEnum = .N5
	@State private var selectedTopic: SentenceTopicEnum = .programming
	
	
	@State private var aiAnswerError: String?
	@EnvironmentObject var sentenceViewModel: SentenceViewModel
		
	
	@State var answer: String = ""
	@State private var submittedAnswer: Bool = false
	
	@State private var answerWasCorrect: AISentenceResponse?
	

    var body: some View {
		NavigationStack {
			Form {
				if let sentence {
					
					SentenceItemHeaderView(sentence: sentence)
						
					if let answerWasCorrect {
						SentenceFeedbackView(aiSentenceReport: answerWasCorrect)

					}
					
				} else {
					Section("Generation Options") {
						NewSenteceDifficultyPicker(
							selectedDifficulty: $selectedDifficulty
						)
						NewSentenceTopicPicker(
							selectedTopic: $selectedTopic
						)
					}
					
				}
				
				if let aiAnswerError {
					Section {
						ForEach(aiAnswerError.split(separator: "\n"), id: \.self) { row in
							Text(row)
						}
						
							
						
					}
				}
				
			}
			.onChange(of: isAnswering, { old, new in
				print("isAnswering changed from \(old) to \(new)")
			})
			.navigationTitle("Generate New Sentence")
			.toolbar {
				if sentence == nil {
					ToolbarSpacer(.flexible, placement: .bottomBar)
					ToolbarItemGroup(placement: .bottomBar) {
						Button(role: .confirm) {
							generateSentence()
						} label: {
							Image(systemName: (isAnswering) ? "apple.intelligence" : "apple.intelligence")
								.contentTransition(.symbolEffect(.automatic))
								.symbolEffect(
									.rotate.byLayer,
									options: isAnswering ? .repeat(.periodic(delay: 0.0)) : .default,
									value: isAnswering
								)
							
						}
						.disabled(isAnswering)
					}
				} else {
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
						
//						TOOD: find a way to fix this 
//						ToolbarItem(placement: .bottomBar) {
//							Button(role: .confirm) {
//								generateSentence()
//								
//							} label: {
//								Image(systemName: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath")
//							}
//						}
						
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
								rateAnswer()
							} label: {
								Image(systemName: isAnswering ? "apple.intelligence" : "paperplane.fill")
									.contentTransition(.symbolEffect(.replace))
									.symbolEffect(
										.rotate.byLayer,
										options: isAnswering ? .repeat(.periodic(delay: 0.0)) : .default,
										value: isAnswering
									)
							}
						}
					}
				}
			}
		}
    }
	
	func generateSentence() {
		withAnimation {
			self.sentence = nil
			self.answerWasCorrect = nil
			aiAnswerError = nil
			self.answer = ""
			self.isAnswering = false // <-- Reset before view appears
		}
		let instructions: String = """
		   You are a Japanese sentence generator. Your task is to create a single, natural, and grammatically correct Japanese sentence that matches the specified JLPT N-Level and topic.
		   - Ensure the sentence is appropriate for the selected proficiency level (N5 = very simple, N1 = advanced).!!!
		   - Use vocabulary and grammar suitable for the level.
		   - The sentence must be relevant to the topic and easy to understand for learners at that level.
		   - Avoid using slang, archaic, or overly complex expressions unless appropriate for the level.
		   - Only use vocabulary that matches the selected JLPT level; avoid advanced vocabulary unless required by the level.
		   - For each new sentence, use a unique grammatical structure or vocabulary that differs from typical or previously generated sentences for the same topic and level.
		   - Avoid set phrases, textbook examples, or overly simple patterns if possible for the selected level.
		   - Vary the sentence length and complexity within the boundaries of the selected JLPT level.
		   - Imagine a new real-life situation or context each time you generate a sentence, and incorporate different names, places, or objects relevant to the topic to make each sentence unique.
		   - Do not generate sentences that are structurally or semantically similar to previous examples.
		   - Strive for originality and variety in both content and structure.
		   - You can use the tools available to you to genereated better responses, you shouls **ALWAYS** check if the grammar is in the known grammar of the user, the topic matches, if the senctence is already in the database (or anything similar) and also if you are using vocabulary that is known to the user. **ALWAYS** check this!
		   - NEVER CREATE ANYTHING INNAPROPRIATE! or other content that might not be seen as PG! Always try to create a family friendly answer! That can be apprichiated by all cultures and every human beeing without being offensive in any way. The content must not be unsafe in any way!!! **ALWAYS** ensure this!
		   - The following where the last generated Senteces, do not ever present these again or anything similar: \(sentenceViewModel.sentences.joined(separator: "\n"))
		   - Be creative when creating the sentence!!!
		   """
		
		let prompt: String = """
		   Please generate a Japanese sentence with these parameters:
		   - JLPT Level: \(selectedDifficulty.rawValue)
		   - Vocubuarly Level: \(selectedDifficulty.rawValue)
		   - Topic: \(selectedTopic.name)
		   - Sentences JLPT-Level: \(selectedDifficulty.rawValue)
		   """
		
		isAnswering = true
		let session = LanguageModelSession(
			tools: [
				KnownGrammarStructuresTool(),
				KnownVocabKanjiTool(),
			],
			instructions: instructions
		)
		session.prewarm()
		
		Task {
			do {
				let newSentence = try await session.respond(
					to: prompt,
					generating: SentenceModel.self
				).content
				
				withAnimation {
					sentence = newSentence
					
					print(newSentence.japanese)
					isAnswering = false
				}
				
				sentenceViewModel.addSentence(newSentence.japanese)
			} catch let error as LanguageModelSession.GenerationError {
				aiAnswerError = error.localizedDescription
				print("generation error")
				print(error.localizedDescription)
				print(error.errorDescription)
				print(error.failureReason?.description ?? "no failureReason")
				print(error.recoverySuggestion?.description ?? 	"no recoverySuggestion")
				print(error.helpAnchor?.description ?? "no helpAnchor")
				isAnswering = false
			} catch let error as LanguageModelSession.ToolCallError {
				aiAnswerError = error.localizedDescription
				print("toolCallError")
				print(error)
				print(error.errorDescription ?? "errorDescription")
				print(error.tool.description)
				
				print(error.failureReason?.description ?? "no failureReason")
				print(error.recoverySuggestion?.description ?? 	"no recoverySuggestion")
				print(error.helpAnchor?.description ?? "no helpAnchor")
				isAnswering = false
			} catch {
				aiAnswerError = error.localizedDescription
				print(error.localizedDescription)
				print("Normal error")
				isAnswering = false
			}
			
		}
	}
	
	func rateAnswer() {
		hideKeyboard()
		if answerWasCorrect == nil && answer.isEmpty {
			return
		}
		
		withAnimation {
			submittedAnswer = true
			isAnswering = true
			answerWasCorrect = nil
		}
		let intructions: String = """
			You are a Japanese learning instructor, this is the sentence the user was presented: '\(sentence?.japanese ?? "")'. Your job is to look if the answer is correct, you can be lenient and allow answers that are logically right but are not exactly the answer: '\(sentence?.english ?? "")'.
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
				isAnswering = false
			}
		}
	}

}

#Preview {
    GenerateNewSentenceSheetView()
}
