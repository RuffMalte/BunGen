//
//  NewSentenceLengthPicker.swift
//  BunGen
//
//  Created by Malte Ruff on 29.06.25.
//

import SwiftUI

struct NewSentenceLengthPicker: View {
	@Binding var selectedSentenceLength: SentenceLengthEnum
	
    var body: some View {
		Picker("", selection: $selectedSentenceLength) {
			ForEach(SentenceLengthEnum.allCases) { length in
				Label(length.title, systemImage: length.icon)
					.tag(length)
			}
		}
    }
}

#Preview {
	NewSentenceLengthPicker(selectedSentenceLength: .constant(.short))
}
