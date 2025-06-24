//
//  MM_KownVocab.swift
//  BunGen
//
//  Created by Malte Ruff on 24.06.25.
//
import Foundation

struct MM_KownVocab: Codable {
	var success: Bool
	var items: [MM_KownVocabItem]
	
	
	
	struct MM_KownVocabItem: Codable {
		var _id: String
		var item: String
		var level: Int
	}
}
