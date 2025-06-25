//
//  SentencesMainView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI

struct SentencesMainView: View {
	
	@Namespace var namespace
	@EnvironmentObject var sentenceViewModel: SentenceViewModel

	@State private var isShowingSettingsView: Bool = false

    var body: some View {
		NavigationStack {
			Form {
				Button {
					sentenceViewModel.addInitialSentences(n5ProgrammingSentences)
				} label: {
					Text("Add default sentences")
				}
				ForEach(sentenceViewModel.sentences, id: \.self) { sentence in
					Text(sentence)
					
				}
			}
			
			.sheet(isPresented: $isShowingSettingsView) {
				SettingsMainView()
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					HStack {
						Menu {
	
						} label: {
							Label("Statistics", systemImage: "chart.bar.fill")
						}
						
						Button {
							isShowingSettingsView.toggle()
						} label: {
							Label("Settings", systemImage: "gearshape.fill")
						}
					}
					
					
				}
			}
//				ForEach(nLevel.allCases, id: \.self) { level in
//					let sentencesForLevel = SentenceModel.samples.filter { $0.level == level }
//					if !sentencesForLevel.isEmpty {
//						Section(level.rawValue) {
//							ForEach(sentencesForLevel) { sentence in
//								NavigationLink {
//									Form {
//										SentenceItemView(sentence: sentence)
//											.navigationTransition(.zoom(sourceID: "icon", in: namespace))
//											.navigationTitle("Review Sentence")
//									}
//								} label: {
//									Label {
//										VStack(alignment: .leading) {
//											Text(sentence.japanese)
//											
//											Text(sentence.romanized)
//												.font(.system(.caption2, design: .default, weight: .light))
//												.foregroundColor(.secondary)
//										}
//									} icon: {
//										Image(systemName: "calendar")
//									}
//									.matchedTransitionSource(id: "icon", in: namespace)
//								}
//								.swipeActions(
//									edge: .trailing,
//									allowsFullSwipe: true) {
//										Button(role: .destructive) {
//											
//										} label: {
//											Label("Remove", systemImage: "trash.fill")
//										}
//										Button {
//											 
//										} label: {
//											Label("Edit", systemImage: "square.and.pencil")
//										}
//										.tint(.yellow)
//									}
//							}
//						}
//					}
//				}
//			}
			.navigationTitle("Sentences")
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

#Preview {
    SentencesMainView()
}
