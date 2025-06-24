//
//  MM_KownKanji.swift
//  BunGen
//
//  Created by Malte Ruff on 24.06.25.
//
import Foundation


struct MM_KownKanji: Codable {
	var success: Bool
	var items: [MM_KownKanjiItem]
	
	
	
	struct MM_KownKanjiItem: Codable {
		var _id: String
		var item: String
		var level: Int
	}
}
