//
//  SentencesMainView.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import SwiftData

struct SentencesMainView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Query private var sentences: [SentenceModel]

    var body: some View {
		NavigationStack {
			Form {
				ForEach(sentences) { sentence in
					Text(sentence.generatedSentence.japanese)
				}
				.onDelete(perform: deleteSentence)

				
			}
			.navigationTitle("Sentences")
			.navigationBarTitleDisplayMode(.inline)

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

		}
    }
	
	private func deleteSentence(at offsets: IndexSet) {
		for index in offsets {
			let sentence = sentences[index]
			modelContext.delete(sentence)
		}
	}
}

#Preview {
    SentencesMainView()
}
