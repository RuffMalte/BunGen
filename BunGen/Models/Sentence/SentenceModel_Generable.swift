//
//  SentenceModel_Generable.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import FoundationModels
import SwiftData

@Generable
struct SentenceModel_Generable: Identifiable, Codable {
	var id: String = UUID().uuidString
	
	var level: jlptLevelEnum
	
	var japanese: String
	var english: String
	var romanized: String
	
}

extension SentenceModel_Generable {
	static let samples: [SentenceModel_Generable] = [
		SentenceModel_Generable(
			level: .N5,
			japanese: "わたしは学生です。",
			english: "I am a student.",
			romanized: "Watashi wa gakusei desu."
		),
		SentenceModel_Generable(
			level: .N5,
			japanese: "これは本です。",
			english: "This is a book.",
			romanized: "Kore wa hon desu."
		),
		SentenceModel_Generable(
			level: .N4,
			japanese: "毎日、日本語を勉強します。",
			english: "I study Japanese every day.",
			romanized: "Mainichi, nihongo o benkyou shimasu."
		),
		SentenceModel_Generable(
			level: .N4,
			japanese: "昨日、友達と映画を見ました。",
			english: "Yesterday, I watched a movie with my friend.",
			romanized: "Kinou, tomodachi to eiga o mimashita."
		),
		SentenceModel_Generable(
			level: .N3,
			japanese: "雨が降っているので、傘を持って行きます。",
			english: "Since it’s raining, I’ll take an umbrella.",
			romanized: "Ame ga futte iru node, kasa o motte ikimasu."
		),
		SentenceModel_Generable(
			level: .N3,
			japanese: "彼は日本に三年間住んでいました。",
			english: "He lived in Japan for three years.",
			romanized: "Kare wa nihon ni san nenkan sunde imashita."
		),
		SentenceModel_Generable(
			level: .N2,
			japanese: "この問題は簡単そうに見えるが、実は難しい。",
			english: "This problem looks easy, but it’s actually difficult.",
			romanized: "Kono mondai wa kantan sou ni mieru ga, jitsu wa muzukashii."
		),
		SentenceModel_Generable(
			level: .N2,
			japanese: "彼女は医者になるために、一生懸命勉強している。",
			english: "She is studying hard to become a doctor.",
			romanized: "Kanojo wa isha ni naru tame ni, isshoukenmei benkyou shite iru."
		),
		SentenceModel_Generable(
			level: .N1,
			japanese: "環境問題は私たち全員が取り組むべき課題です。",
			english: "Environmental issues are challenges we all should address.",
			romanized: "Kankyou mondai wa watashitachi zen’in ga torikumu beki kadai desu."
		),
		SentenceModel_Generable(
			level: .N1,
			japanese: "彼の意見は非常に説得力がありました。",
			english: "His opinion was very persuasive.",
			romanized: "Kare no iken wa hijou ni settokuryoku ga arimashita."
		)
	]
}
