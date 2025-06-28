//
//  SentenceItemHeaderView.swift
//  BunGen
//
//  Created by Malte Ruff on 25.06.25.
//

import SwiftUI

struct SentenceItemHeaderView: View {
	
	let sentence: SentenceModel_Generable
	
    var body: some View {
		Section {
			HStack {
				Spacer()
				VStack(alignment: .center) {
					Text(sentence.japanese)
					
					Text(sentence.romanized)
						.font(
							.system(
								.caption2,
								design: .rounded,
								weight: .regular
							)
						)
						.foregroundStyle(.secondary)
				}
				Spacer()
			}
			.padding(.vertical, 40)
		}
		.overlay {
			VStack {
				HStack {
					Spacer()
					SentenceJLPTLevelView(jlptLevel: sentence.level)
				}
				Spacer()
			}
		}
	}
}

#Preview {
	Form {
		SentenceItemHeaderView(sentence: SentenceModel_Generable.samples.first!)
	}
}
