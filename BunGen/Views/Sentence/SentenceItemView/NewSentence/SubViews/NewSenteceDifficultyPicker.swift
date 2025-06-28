//
//  NewSenteceDifficultyPicker.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI

struct NewSenteceDifficultyPicker: View {
	
	@Binding var selectedDifficulty: jlptLevelEnum
	
    var body: some View {
		Picker(selection: $selectedDifficulty) {
			ForEach(jlptLevelEnum.allCases) { level in
				Label(level.rawValue, systemImage: level.icon)
					.tag(level)
			}
			
		} label: {
			Text("Pick a difficulty level")
		}
    }
}

#Preview {
	NewSenteceDifficultyPicker(selectedDifficulty: .constant(.N4))
}
