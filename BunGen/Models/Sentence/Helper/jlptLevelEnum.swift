//
//  jlptLevelEnum.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//
import SwiftUI
import FoundationModels

@Generable
enum jlptLevelEnum: String, CaseIterable, Identifiable {
	case N5
	case N4
	case N3
	case N2
	case N1
	
	var id : String {
		self.rawValue
	}
	
	var color: Color {
		switch self {
		case .N5:
			return .red
		case .N4:
			return .orange
		case .N3:
			return .yellow
		case .N2:
			return .green
		case .N1:
			return .blue
		}
	}
	
	var icon: String {
		switch self {
		case .N5:
			return "5.circle.fill"
		case .N4:
			return "4.circle.fill"
		case .N3:
			return "3.circle.fill"
		case .N2:
			return "2.circle.fill"
		case .N1:
			return "1.circle.fill"
		}
	}
}
