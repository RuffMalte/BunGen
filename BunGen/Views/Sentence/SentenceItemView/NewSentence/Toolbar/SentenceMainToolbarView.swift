//
//  MainToolbarView.swift
//  BunGen
//
//  Created by Malte Ruff on 28.06.25.
//
import SwiftUI

struct SentenceMainToolbarView: ToolbarContent {
	@Binding var sentence: SentenceModel?
	@Binding var answerWasCorrect: AISentenceResponse?
	@Binding var answer: String
	@Binding var isAnswering: Bool
	let generateSentence: () -> Void
	let rateAnswer: () -> Void
	
	var body: some ToolbarContent {
		Group {
			if sentence == nil {
				ToolbarItem(placement: .bottomBar) {
					Spacer()
				}
				ToolbarItemGroup(placement: .bottomBar) {
					GenerateButton(isAnswering: $isAnswering, action: generateSentence)
				}
			} else {
				if answerWasCorrect != nil {
					ToolbarItem(placement: .bottomBar) {
						Spacer()
					}
					ToolbarItem(placement: .bottomBar) {
						Button(role: .confirm) {
							withAnimation {
								sentence = nil
							}
						} label: {
							Image(systemName: "arrow.trianglehead.2.clockwise")
						}
					}
				} else {
					ToolbarItem(placement: .bottomBar) {
						Button {
							hideKeyboard()
						} label: {
							Label("Hide keyboard", systemImage: "keyboard.chevron.compact.down.fill")
								.labelStyle(.iconOnly)
						}
					}
					ToolbarItem(placement: .bottomBar) {
						Spacer()
					}
					ToolbarItem(placement: .bottomBar) {
						TextField("Your Answer", text: $answer, axis: .vertical)
							.lineLimit(1, reservesSpace: true)
							.textFieldStyle(.plain)
							.padding(.horizontal, 6)
					}
					ToolbarItem(placement: .bottomBar) {
						Spacer()
					}
					ToolbarItem(placement: .bottomBar) {
						Button(role: .confirm) {
							rateAnswer()
						} label: {
							Image(systemName: isAnswering ? "apple.intelligence" : "paperplane.fill")
								.contentTransition(.symbolEffect(.replace))
								.symbolEffect(
									.rotate.byLayer,
									options: isAnswering ? .repeat(.periodic(delay: 0.0)) : .default,
									value: isAnswering
								)
						}
					}
				}
			}
		}
	}
}
