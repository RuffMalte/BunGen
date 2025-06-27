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
			ForEach(MainTabs.allCases, id: \.self) { tab in
				 Tab(
					tab.title,
					systemImage: tab.icon,
					value: tab
				 ) {
					 tab.view
				 }
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
				Text("Hello 2")
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

