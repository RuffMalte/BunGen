//
//  ModifiySentenceView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import FoundationModels

struct ModifiySentenceView: View {
	
	@State var sentence: SentenceModel?
	
	
	@State private var isAnswering = false
	
	

	@State var selectedDifficulty: nLevel = .N5
	@State private var selectedTopic: Topic = .programming

	@State private var aiAnswerError: String?
	
    var body: some View {
		NavigationStack {
			Form {
				if let sentence {
					
					SentenceItemView(sentence: sentence)
					
					Button {
						withAnimation {
							self.sentence = nil
						}
						
					} label: {
						Label("New Sentence", systemImage: "arrow.trianglehead.2.clockwise")
					}
					
					Button {
						withAnimation {
							self.sentence = nil
							generateSentence()
						}
						
					} label: {
						Label("New Sentence (with same Parameters)", systemImage: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath")
					}
					
				} else {
					Section("Generation options") {
						Picker(selection: $selectedDifficulty) {
							ForEach(nLevel.allCases) { level in
								Label(level.rawValue, systemImage: level.icon)
									.tag(level)
							}
							
						} label: {
							Text("Pick a difficulty level")
						}
						
						Picker(selection: $selectedTopic) {
							ForEach(Topic.allCases) { topic in
								Label(topic.name, systemImage: topic.icon)
									.tag(topic)
							}
						} label: {
							Text("Pick a topic")
						}
					}
					
					Section {
						Button {
							generateSentence()
						} label: {
							Label {
								Text("Generate new Sentence")
							} icon: {
								if !isAnswering {
									Image(systemName: "apple.intelligence")
								} else {
									Image(systemName: "apple.intelligence")
										.symbolEffect(.bounce.up.byLayer, options: .repeat(.periodic(delay: 0.0)))
								}
							}
							
						}
						.disabled(isAnswering)
						
					}
					if let aiAnswerError {
						Section {
							ContentUnavailableView {
								Image(systemName: "inset.filled.bottomhalf.tophalf.rectangle")
							} description: {
								Text(aiAnswerError)
									.foregroundStyle(.red)
							} actions: {
								Button {
									isAnswering = false
									generateSentence()
								} label: {
									Label("Retry", systemImage: "arrow.trianglehead.2.clockwise")
										.labelStyle(.titleAndIcon)
								}
								.buttonStyle(.borderedProminent)

							}
						}
						.onAppear {
							withAnimation {
								isAnswering = false
							}
						}
					}
					
				}
			}
			.navigationTitle("New Sentence")

		}
    }
	
	func generateSentence() {
		withAnimation {
			isAnswering = true
			aiAnswerError = nil
		}
		
		let instructions: String = """
			You are a Japanese sentence generator. Your task is to create a single, natural, and grammatically correct Japanese sentence that matches the specified JLPT N-Level and topic.
			- Ensure the sentence is appropriate for the selected proficiency level (N5 = very simple, N1 = advanced).
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
			"""
		
		let prompt: String = """
			Please generate a Japanese sentence with these parameters:
			- JLPT Level: \(selectedDifficulty.rawValue)
			- Vocubuarly Level: \(selectedDifficulty.rawValue)
			- Topic: \(selectedTopic.name)
			"""
		
		
		let session = LanguageModelSession(
			tools: [], //TODO: add tools, marumori lookup from cache, sentences that have be already created (swift data)
			instructions: instructions
		)
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
			} catch(let error) {
				print(error)
				aiAnswerError = error.localizedDescription
			}
			
		}
	}
}

#Preview {
	ModifiySentenceView(sentence: SentenceModel.samples.first)
}
