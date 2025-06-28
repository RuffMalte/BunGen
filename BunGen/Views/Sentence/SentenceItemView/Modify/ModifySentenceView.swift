//
//  ModifySentenceView.swift
//  BunGen
//
//  Created by Malte Ruff on 28.06.25.
//

import SwiftUI

struct ModifySentenceView: View {
	@Bindable var sentence: SentenceModel
	
    var body: some View {
		Form {
			
			Section {
				
				Text(sentence.userInput)
				
				
				
			}
			
			
			SentenceFeedbackView(
				aiSentenceReport: sentence.aiAnswerForUserInput
			)
			
		}
    }
}

#Preview {
	ModifySentenceView(sentence: SentenceModel.sampleData.first!)
}
