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
	var userInput: String?
	var aiAnswerForUserInput: AISentenceResponse?
	var senteceTopic: SentenceTopicEnum?
	
	
	init(generatedSentence: SentenceModel_Generable) {
		self.id = generatedSentence.id
		self.generatedSentence = generatedSentence
	}
	
	var icon: String = "square.and.arrow.up"
	var dateAdded: Date = Date()
}

extension SentenceModel {
	static let sampleData: [SentenceModel] = [
		.init(generatedSentence: .samples[0]),
		.init(generatedSentence: .samples[1]),
		.init(generatedSentence: .samples[2]),
		.init(generatedSentence: .samples[3]),
		.init(generatedSentence: .samples[4]),
		.init(generatedSentence: .samples[5]),
		.init(generatedSentence: .samples[6]),
		.init(generatedSentence: .samples[7])
	]
}
