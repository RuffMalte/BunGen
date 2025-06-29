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
	@State private var selectedSentenceLength: SentenceLengthEnum = .long
	
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
				selectedTopic: $selectedTopic,
				selectedSentenceLength: $selectedSentenceLength
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
		print(latestItems.map { $0.generatedSentence.japanese }.joined(separator: "|"))
		
		let instructions: String = """
		## Output Diversity & Originality

		- **Absolute Ban on Repetition**:
		  - Do NOT reuse any sentence structure, verb, location, or name from the last 30 outputs.
		  - Do NOT copy or closely mimic any example or previous sentence, even with different words.
		  - Never use placeholder text like [キャラクター名] or [UniquePlace]; always generate unique, realistic Japanese names and locations.
		- **Creativity & Challenge**:
		  - Every sentence must be a *mini-story* with a surprising or imaginative twist, suitable for the selected JLPT level.
		  - Avoid textbook or template patterns.
		  - Use unusual verbs, locations, and character actions that have not appeared recently.
		- **Grammar & JLPT Level**:
		  - Use only grammar, vocabulary, and conjugations appropriate for the specified JLPT level.
		  - For higher levels (N3, N2, N1), avoid basic patterns like「[X]は[Y]が好きです」「[X]で[Y]をします」「[X]は[Y]で[Z]をしています」entirely.
		  - Integrate advanced or less common grammar for N3+ (e.g., 〜ながら, 〜そう, passive, causative, 〜ば〜ほど, 〜ずにはいられない).
		- **Structural & Demographic Variety**:
		  - Rotate character demographics: child (くん/ちゃん), adult (さん), elder (おじいさん/おばあさん).
		  - Vary sentence structure: SVO, SOV, use of conditionals, passives, causatives, and different verb forms.
		  - Ensure at least three distinct sentence patterns for every five sentences.
		- **Novelty Enforcement**:
		  - Block any location-verb pair that matches any of the last 30 outputs.
		  - Require sensory or emotional detail (e.g., smells, textures, feelings).
		  - Vary temporal context (e.g., 明日の朝, 1999年, 雨の日).
		  - Try to minimize the reuse of names.
		- **Validation**:
		  - Compare new output to \(latestItems.suffix(60).map { $0.generatedSentence.japanese }.joined(separator: "|")) and do create if any pattern, location, verb, or name is similar.
		  - Dont create a sentence if the sentence is not fun, surprising, or feels repetitive.
		  ## Output Diversity & Originality (Enhanced)
		  
		  - **Pattern Disruption Protocol**:
		  - Enforce 3+ structural variants per 5 sentences (SOV, passive, causative, conditional)
		  
		  - **Lexical Innovation Engine**:
		  - Ban top 10 most frequent verbs from history
		  - Mandate location-action pairs with +70% novelty score
		  - Require sensory vocabulary (e.g., ごつごつ, 芳しい) in 80% of outputs
		  - Enforce demographic-context pairing:
			| Demographic   | Context Requirement          |
			|---------------|------------------------------|
			| Child (くん)  | Imaginative/fantasy element  |
			| Adult (さん)  | Professional/technical detail|
			| Elder (様)    | Historical/traditional reference |
		  
		  - **Temporal Constraints**:
		  - Rotate time periods: 60% present, 20% past, 20% future
		  - Require time-specific vocabulary (e.g., 明け方, 真夜中)
		  
		  - **Validation Upgrade**:
		  - Reject if verb conjugation pattern matches last 15 outputs
		"""
		
		
		
		let prompt: String = """
		# Japanese Mini-Story Sentence Generation

		## Parameters
		- JLPT Level: \(selectedDifficulty.rawValue)
		- Topic: \(selectedTopic.name)
		- Length: \(selectedSentenceLength.title) (\(selectedSentenceLength.rangeInWords))
		- Style: Creative, context-rich mini-story

		## Output Rules
		1. Strict word count: \(selectedSentenceLength.rangeInWords)
		2. Required elements:
		   - Unique, realistic Japanese character name (not used in last 15 outputs)
		   - Fresh, unconventional location (not used in previous 20 sentences)
		   - Action verb, conjugated appropriately for JLPT level, never repeated from last 20 outputs
		   - Demographic rotation: child, adult, elder (cycle with each new sentence)
		3. Banned patterns:
		   - Never use: [X]は[Y]が好きです, [X]で[Y]をします, [X]は[Y]で[Z]をしています
		   - Do not use any structure, verb, or location from recent outputs
		4. Mandatory:
		   - At least one advanced grammar/conjugation (e.g., honorifics, conditionals, passive, causative, 〜ながら, 〜そう, etc. as appropriate for JLPT level)
		   - Sensory or emotional detail, or an unexpected consequence
		   - Temporal context (e.g., time of day, year, weather)
		5. Do not use placeholders or example text; always generate real content.
		Generate a single, self-contained Japanese sentence that is original, fun, and challenging for the learner, following all above rules.
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
		
		print("sentence" + (sentence?.japanese ?? "NIL"))
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
			print("sentence" + (sentence?.japanese ?? "NIL"))
			
			if let sentence, let answerWasCorrect {
				let newSwiftDataModel = SentenceModel(
					generatedSentence: sentence,
					userInput: answer,
					aiAnswerForUserInput: answerWasCorrect,
					senteceTopic: selectedTopic
				)
				
				modelContext.insert(newSwiftDataModel)
				try? modelContext.save()
			}
		}
		
	}

}

#Preview {
    GenerateNewSentenceSheetView()
}
