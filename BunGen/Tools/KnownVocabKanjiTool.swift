//
//  KnownVocabularyTool.swift
//  BunGen
//
//  Created by Malte Ruff on 23.06.25.
//

import Foundation
import FoundationModels


struct KnownVocabKanjiTool: Tool {

	
	
	let name: String = "known-vocabulary"
	let description: String = "Generates a list of all known vocabulary terms."
	
	@Generable
	struct Arguments {
		@Guide(description: "The level of the vocabulary to get", .range(1...5))
		var JLPTLevel: Int
	}
	
	
	func call(arguments: Arguments) async throws -> ToolOutput {
		
		var known: [String] = []
		
		let mmVm = MaruMoriViewModel()
		
		do {
			// MARK: Vocab
			let filteredVocabFromMM = try mmVm.filterKownVocabItemsByLevel(
				from: "kown-vocab.json",
				range: 4...9
			)
			
			let last250Vocab = filteredVocabFromMM
				.suffix(250)
				.toStringArray { "\($0.item)" }
			
			known.append(contentsOf: last250Vocab)
			
			// MARK: Kanji
			let filteredKanjiFromMM = try mmVm.filterKownKanjiItemsByLevel(
				from: "known-kanji.json",
				range: 4...9
			)
			
			
			let last250Kanji = filteredKanjiFromMM
				.suffix(250)
				.toStringArray { "\($0.item)" }
			
			known.append(contentsOf: last250Kanji)

			
			
			
			//TODO: limit this to maybe 500 entries and just say all the ones that would typically be learned before
		} catch(let error) {
			print(error.localizedDescription)
		}
		
		
		print("Called KownVocabularyTool, with JLTP-Level: \(arguments.JLPTLevel) \n \n Found: \(known.count) known terms")
		
		
		var formattedOutput: String = "Please use all the following, aswell as the ones that would be logically learned before the ones that are following. So for example, if there would be 木　its be to expected that the user would also know いい　and 良し\n"
		formattedOutput = known.joined(separator: "\n")
		
		
		return ToolOutput(formattedOutput)
	}
	
	
	
	
}


struct MM_KownVocab: Codable {
	var success: Bool
	var items: [MM_KownVocabItem]
	
	
	
	struct MM_KownVocabItem: Codable {
		var _id: String
		var item: String
		var level: Int
	}
}

struct MM_KownKanji: Codable {
	var success: Bool
	var items: [MM_KownKanjiItem]
	
	
	
	struct MM_KownKanjiItem: Codable {
		var _id: String
		var item: String
		var level: Int
	}
}
