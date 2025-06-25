//
//  MaruMoriViewModel.swift
//  BunGen
//
//  Created by Malte Ruff on 24.06.25.
//

import Foundation

class MaruMoriViewModel {
	
	let jsonHelper: JsonHelper = JsonHelper()
	
	
	func filterKownVocabItemsByLevel(
		from path: String,
		range: ClosedRange<Int>
	) throws -> [MM_KownVocab.MM_KownVocabItem] {
		let vocab = try jsonHelper.decodeJSON(from: path, as: MM_KownVocab.self)
		return vocab.items.filter { range.contains($0.level) }
	}
	
	func filterKownKanjiItemsByLevel(
		from path: String,
		range: ClosedRange<Int>
	) throws -> [MM_KownVocab.MM_KownVocabItem] {
		let vocab = try jsonHelper.decodeJSON(from: path, as: MM_KownVocab.self)
		return vocab.items.filter { range.contains($0.level) }
	}
	
	
	
	
}
