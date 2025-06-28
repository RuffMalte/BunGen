//
//  GenerateNewSentenceSheetView.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI
import FoundationModels
import SwiftData

struct GenerateNewSentenceSheetView: View {
	@State var sentence: SentenceModel_Generable?
	@State private var isAnswering = false
	
	@State var selectedDifficulty: jlptLevelEnum = .N5
	@State private var selectedTopic: SentenceTopicEnum = .programming
	
	@State private var aiAnswerError: String?
	@State private var submittedAnswer: Bool = false
	
	@State var answer: String = ""
	@State private var answerWasCorrect: AISentenceResponse?

	
	@Environment(\.modelContext) private var modelContext
	@Query private var latestItems: [SentenceModel]
	
	init() {
		var fetchDescriptor = FetchDescriptor<SentenceModel>(
			sortBy: [SortDescriptor(\SentenceModel.dateAdded, order: .reverse)]
		)
		fetchDescriptor.fetchLimit = 150
		_latestItems = Query(fetchDescriptor)
	}

	
	
	var body: some View {
		NavigationStack {
			SentenceFormView(
				sentence: sentence,
				answerWasCorrect: answerWasCorrect,
				aiAnswerError: aiAnswerError,
				selectedDifficulty: $selectedDifficulty,
				selectedTopic: $selectedTopic
			)
			.navigationTitle("Generate New Sentence")
			.toolbar {
				SentenceMainToolbarView(
					sentence: $sentence,
					answerWasCorrect: $answerWasCorrect,
					answer: $answer,
					isAnswering: $isAnswering,
					generateSentence: generateSentence,
					rateAnswer: rateAnswer
				)
			}
		}
	}
	
	func generateSentence() {
		withAnimation {
			self.sentence = nil
			self.answerWasCorrect = nil
			aiAnswerError = nil
			self.answer = ""
			self.isAnswering = true
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
			- The following where the last generated Senteces, do not ever present these again or anything similar: \(         latestItems.map { $0.generatedSentence.japanese }.joined(separator: "\n"))
			- Be creative when creating the sentence!!!
		"""
		
		let prompt: String = """
		   Please generate a Japanese sentence with these parameters:
		   - JLPT Level: \(selectedDifficulty.rawValue)
		   - Vocubuarly Level: \(selectedDifficulty.rawValue)
		   - Topic: \(selectedTopic.name)
		   - Sentences JLPT-Level: \(selectedDifficulty.rawValue)
		   """
		
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
					generating: SentenceModel_Generable.self
				).content
				
				withAnimation {
					sentence = newSentence
					
					print(newSentence.japanese)
					isAnswering = false
				}
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
		
		if let sentence {
			let newSwiftDataModel = SentenceModel(
				generatedSentence: sentence
			)
			newSwiftDataModel.userInput = answer
			newSwiftDataModel.aiAnswerForUserInput = answerWasCorrect
			newSwiftDataModel.senteceTopic = selectedTopic
			
			modelContext.insert(newSwiftDataModel)
		}
	}

}

#Preview {
    GenerateNewSentenceSheetView()
}
