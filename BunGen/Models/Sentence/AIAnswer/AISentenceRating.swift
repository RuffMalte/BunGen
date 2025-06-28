//
//  AISentenceRating.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//
import SwiftUI
import FoundationModels

@Generable
enum AISentenceRating: String, CaseIterable {
	case good
	case bad
	case mixed
	
	
	var color: Color {
		switch self {
		case .good:
			return .green
		case .bad:
			return .red
		case .mixed:
			return .yellow
		}
	}
	
	var icon: String {
		switch self {
		case .good:
			return "checkmark.circle.fill"
		case .bad:
			return "xmark.circle.fill"
		case .mixed:
			return "exclamationmark.triangle.fill"
		}
	}
	var asText: String {
		switch self {
		case .good:
			return "Good"
		case .bad:
			return "Bad"
		case .mixed:
			return "Mixed"
		}
	}
}
