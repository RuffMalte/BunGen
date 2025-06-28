//
//  SentenceModel.swift
//  BunGen
//
//  Created by Malte Ruff on 28.06.25.
//
import SwiftUI
import SwiftData

@Model
class SentenceModel: Identifiable {
	@Attribute(.unique) var id: String
	var generatedSentence: SentenceModel_Generable
	var userInput: String
	var aiAnswerForUserInput: AISentenceResponse
	var senteceTopic: SentenceTopicEnum
	
	
	init(
		generatedSentence: SentenceModel_Generable,
		userInput: String,
		aiAnswerForUserInput: AISentenceResponse,
		senteceTopic: SentenceTopicEnum,
		icon: String = "square.and.arrow.up",
	) {
		self.id = generatedSentence.id
		self.generatedSentence = generatedSentence
		self.userInput = userInput
		self.aiAnswerForUserInput = aiAnswerForUserInput
		self.senteceTopic = senteceTopic
		self.icon = icon
	}
	
	var icon: String
	var dateAdded: Date = Date()
}

extension SentenceModel {
	static let sampleData: [SentenceModel] = [
		.init(
			generatedSentence: .samples[0],
			userInput: "",
			aiAnswerForUserInput: .sample,
			senteceTopic: .art
		),
		.init(
			generatedSentence: .samples[1],
			userInput: "",
			aiAnswerForUserInput: .sample,
			senteceTopic: .art
		),
		.init(
			generatedSentence: .samples[2],
			userInput: "",
			aiAnswerForUserInput: .sample,
			senteceTopic: .art
		),
	]
}
