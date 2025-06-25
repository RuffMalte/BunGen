//
//  SentenceStorage.swift
//  BunGen
//
//  Created by Malte Ruff on 25.06.25.
//
import Foundation

struct SentenceStorage {
    static let key = "savedSentences"

    static func getSentences() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    static func saveSentences(_ sentences: [String]) {
        UserDefaults.standard.set(sentences, forKey: key)
    }
}
