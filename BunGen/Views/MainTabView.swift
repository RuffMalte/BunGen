//
//  MainTabView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI

struct MainTabView: View {
	
	@State private var isShowingNewSentenceView: Bool = false
	
    var body: some View {
		TabView {
			
			Tab("Sentences", systemImage: "character.bubble.fill") {
				SentencesMainView()
					.overlay {
						VStack {
							Spacer()
							GenerativeView()
								.font(
									.system(
										.headline,
										design: .monospaced,
										weight: .bold
									)
								)
								.padding()
								.glassEffect(.regular.interactive(), in: .capsule)
						}
						.padding(.bottom, 6)
					}
			}
			
			Tab("Sentences", systemImage: "character.bubble") {
				SentencesMainView()
			}
			
			Tab("Sentences", systemImage: "person.fill") {
				SentencesMainView()
					
			}
			
		}
		
		.sheet(isPresented: $isShowingNewSentenceView, content: {
			ModifiySentenceView()
			
		})
		.tabViewBottomAccessory(content: {
			Button {
				isShowingNewSentenceView = true
			} label: {
				Label("New Sentence", systemImage: "plus")
			}
			.multilineTextAlignment(.center)
			.labelStyle(.titleAndIcon)
		})
		.tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    MainTabView()
}
