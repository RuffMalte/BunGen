//
//  SentenceLengthEnum.swift
//  BunGen
//
//  Created by Malte Ruff on 29.06.25.
//

import SwiftUI
import FoundationModels

enum SentenceLengthEnum: String, CaseIterable, Identifiable {
	case short
	case medium
	case long
	case veryLong

	
	var id: String { rawValue }
	
	var title: LocalizedStringKey {
		switch self {
		case .short:
			return "Short"
		case .medium:
			return "Medium"
		case .long:
			return "Long"
		case .veryLong:
			return "Very Long"
		}
	}
	
	var rangeInWords: String {
		switch self {
		case .short: 
			return "5-7 words"
		case .medium: 
			return "8-12 words"
		case .long: 
			return "13-20 words"
		case .veryLong:
			return ">20 words"
		}
	}
	
	var rangeInNumbers: ClosedRange<Int> {
		switch self {
		case .short:
			return 5...7
		case .medium:
			return 8...12
		case .long:
			return 13...20
		case .veryLong:
			return 21...40
		}
	}
	
	var icon: String {
		switch self {
			case .short:
			return "line.horizontal.3"
			case .medium:
			return "line.horizontal.3"
			case .long:
			return "line.horizontal.3"
			case .veryLong:
			return "line.horizontal.3"
		}
	}
	
	var color: Color {
		switch self {
		case .short:
			return .blue
		case .medium:
			return .orange
		case .long:
			return .red
		case .veryLong:
			return .yellow
		}
	}
}


