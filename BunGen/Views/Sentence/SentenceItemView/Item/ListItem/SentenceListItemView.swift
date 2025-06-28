//
//  SentenceListItemView.swift
//  BunGen
//
//  Created by Malte Ruff on 28.06.25.
//

import SwiftUI

struct SentenceListItemView: View {
	
	@Bindable var sentence: SentenceModel
	
    var body: some View {
		HStack {
			
			Image(systemName: sentence.icon)
				.font(.title)
			
			VStack(alignment: .leading) {
				Text(sentence.generatedSentence.japanese)
					.font(.headline)
					.lineLimit(1)
				
				HStack {
					SentenceJLPTLevelView(
						jlptLevel: sentence.generatedSentence.level
					)
					Spacer()
					
					Image(systemName: sentence.senteceTopic.icon)
						.foregroundStyle(.secondary)
					
					
					
				}
			}
		}
    }
}

#Preview {
	SentenceListItemView(sentence: .sampleData.first!)
}
