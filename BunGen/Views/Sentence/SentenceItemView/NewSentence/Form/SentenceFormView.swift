//
//  SentenceFormView.swift
//  BunGen
//
//  Created by Malte Ruff on 28.06.25.
//
import SwiftUI

struct SentenceFormView: View {
    var sentence: SentenceModel_Generable?
    var answerWasCorrect: AISentenceResponse?
    var aiAnswerError: String?
    @Binding var selectedDifficulty: jlptLevelEnum
    @Binding var selectedTopic: SentenceTopicEnum
    
    var body: some View {
        Form {
            if let sentence {
                SentenceItemHeaderView(sentence: sentence)
                if let answerWasCorrect {
                    SentenceFeedbackView(aiSentenceReport: answerWasCorrect)
                }
            } else {
                Section("Generation Options") {
                    NewSenteceDifficultyPicker(selectedDifficulty: $selectedDifficulty)
                    NewSentenceTopicPicker(selectedTopic: $selectedTopic)
                }
            }
            if let aiAnswerError {
                Section {
                    ForEach(aiAnswerError.split(separator: "\n"), id: \.self) { row in
                        Text(row)
                    }
                }
            }
        }
    }
}
