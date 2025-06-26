//
//  MainTabView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI

struct MainTabView: View {
	
	@State private var isShowingNewSentenceView: Bool = false
	
	@State private var selectedTab: MainTabs = .daily
	@State private var isShowingBottomAccessoryToggledSheetView: Bool = false
    var body: some View {
		TabView(selection: $selectedTab) {
			Tab(
				MainTabs.sentences.title,
				systemImage: MainTabs.sentences.icon,
				value: .sentences
			) {
				MainTabs.sentences.view
			}
			Tab(
				MainTabs.trainer.title,
				systemImage: MainTabs.trainer.icon,
				value: .trainer
			) {
				MainTabs.trainer.view
			}
			
			Tab(
				MainTabs.daily.title,
				systemImage: MainTabs.daily.icon,
				value: .daily
			) {
				MainTabs.daily.view
			}
		}
		.tabViewBottomAccessory {
			Button {
				isShowingBottomAccessoryToggledSheetView.toggle()
			} label: {
				selectedTab.bottomAccessory
					.labelStyle(.titleAndIcon)
			}

			
		}
		.tabViewStyle(.sidebarAdaptable)
		.sheet(isPresented: $isShowingBottomAccessoryToggledSheetView) {
			switch selectedTab {
			case .sentences:
				ModifiySentenceView()
			case .daily:
				ModifySheetView()
			case .trainer:
				Text("Hello 3")
			}
		}
		.tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    MainTabView()
}

enum MainTabs: String, CaseIterable, Hashable {
	case trainer
	case daily
	case sentences
	
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
