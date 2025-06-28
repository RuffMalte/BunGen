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
	var generatedSentence: SentenceModel_Generable // Must be Codable
	
	init(generatedSentence: SentenceModel_Generable) {
		self.id = generatedSentence.id
		self.generatedSentence = generatedSentence
	}
	
	var icon: String = "square.and.arrow.up"
	var dateAdded: Date = Date()
}
