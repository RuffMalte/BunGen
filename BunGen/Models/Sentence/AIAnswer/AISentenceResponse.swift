//
//  AISentenceResponse.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI
import FoundationModels

@Generable
struct AISentenceResponse {
	var rating: AISentenceRating
	
	@Guide(description: "Your confidence in the answer")
	var confidence: Double = 0.0
	var explanation: String
	var corrected: String?
	var suggestions: [String] = []
	
}

extension AISentenceResponse {
	static let sample: AISentenceResponse = AISentenceResponse(
		rating: .good,
		confidence: 0.9,
		explanation: "This is correct.",
		corrected: nil,
		suggestions: []
	)
}
