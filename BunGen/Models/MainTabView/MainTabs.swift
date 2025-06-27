//
//  MainTabs.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI

enum MainTabs: String, CaseIterable, Hashable {
	case sentences
	case trainer
	case daily
	
	
	var title: String {
		switch self {
		case .trainer:
			return "Trainer"
		case .daily:
			return "Daily"
		case .sentences:
			return "Sentences"
		}
	}
	
	var icon: String {
		switch self {
		case .trainer:
			return "dumbbell.fill"
		case .daily:
			return "calendar"
		case .sentences:
			return "character.bubble.fill"
		}
	}
	
	@ViewBuilder var view: some View {
		switch self {
		case .trainer:
			KanaTrainerMainView()
		case .daily:
			DailyMainView()
		case .sentences:
			SentencesMainView()
		}
	}
	
	@ViewBuilder var bottomAccessory: some View {
		switch self {
		case .trainer:
			Label("Open Trainer", systemImage: "dumbbell.fill")
		case .daily:
			Label("New Daily", systemImage: "chevron.down")
		case .sentences:
			Label("New Sentence", systemImage: "apple.intelligence")
		}
	}
}
