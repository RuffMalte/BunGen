//
//  NewSentenceTopicPicker.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI

struct NewSentenceTopicPicker: View {
	
	@Binding var selectedTopic: SentenceTopicEnum

    var body: some View {
		Picker(selection: $selectedTopic) {
			ForEach(SentenceTopicEnum.allCases) { topic in
				Label(topic.name, systemImage: topic.icon)
					.tag(topic)
			}
		} label: {
			Text("Pick a topic")
		}
    }
}

#Preview {
	NewSentenceTopicPicker(selectedTopic: .constant(.food))
}
