//
//  SentenceFeedbackView.swift
//  BunGen
//
//  Created by Malte Ruff on 25.06.25.
//

import SwiftUI

struct SentenceFeedbackView: View {
	let aiSentenceReport: AISentenceResponse
	
    var body: some View {
		Section {
			HStack {
				Image(systemName: aiSentenceReport.rating.icon)
					.foregroundStyle(aiSentenceReport.rating.color)
					.font(.largeTitle)
				
				VStack(alignment: .leading) {
					Text(aiSentenceReport.rating.asText)
						.font(
							.system(
								.largeTitle,
								design: .rounded,
								weight: .bold
							)
						)
					
					Text(aiSentenceReport.confidence, format: .number)
						.font(
							.system(
								.footnote,
								design: .monospaced,
								weight: .bold
							)
						)
				}
				Spacer()
			}
			Text(aiSentenceReport.explanation)
			if let corrected = aiSentenceReport.corrected {
				Text("Corrected: " + corrected)
			}
			
			VStack {
				ForEach(aiSentenceReport.suggestions, id: \.self) { sugg in
					Text(sugg)
				}
			}
			
		}
    }
}

#Preview {
	SentenceFeedbackView(aiSentenceReport: AISentenceResponse.sample)
}
