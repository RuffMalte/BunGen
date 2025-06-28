//
//  SentenceJLPTLevelView.swift
//  BunGen
//
//  Created by Malte Ruff on 28.06.25.
//

import SwiftUI

struct SentenceJLPTLevelView: View {
	
	let jlptLevel: jlptLevelEnum
	
    var body: some View {
		Text(jlptLevel.rawValue)
			.foregroundStyle(jlptLevel.color.gradient)
			.font(
				.system(
					.headline,
					design: .rounded,
					weight: .black
				)
			)
    }
}

#Preview {
	SentenceJLPTLevelView(jlptLevel: .N5)
}
