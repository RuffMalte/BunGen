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
			if sentences.isEmpty {
				ContentUnavailableView {
					Label("No saved sentences yet", systemImage: "exclamationmark.bubble.fill")
				} description: {
					Text("Get started by pressing the button below.")
				}

			} else {
				Form {
					Section {
						LazyVGrid(
							columns: Array(repeating: GridItem(.flexible()), count: 2),
							spacing: 10
						) {
								
								VStack {
									Text("Sentences")
										.font(
											.system(
												.headline,
												design: .rounded,
												weight: .bold
											)
										)
									
									Text(sentences.count, format: .number)
										.font(
											.system(
												.largeTitle,
												design: .monospaced,
												weight: .black
											)
										)
								}
								
								VStack {
									
									Text("Correct")
										.font(
											.system(
												.headline,
												design: .rounded,
												weight: .bold
											)
										)
									let numberOfTimesCorrect = sentences.filter { $0.aiAnswerForUserInput.rating == .good }.count

									Text(numberOfTimesCorrect, format: .number)
										.font(
											.system(
												.largeTitle,
												design: .monospaced,
												weight: .black
											)
										)
								}
								
							}
					}
					.listRowBackground(Color.clear)
					.listRowInsets(.all, 0)
					
					ForEach(sentences) { sentence in
						NavigationLink {
							ModifySentenceView(sentence: sentence)
						} label: {
							SentenceListItemView(sentence: sentence)
						}
						
					}
					.onDelete(perform: deleteSentence)
					
					
				}
				.navigationTitle("Sentences")
				.navigationBarTitleDisplayMode(.inline)
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
