//
//  SentenceModel.swift
//  BunGen
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import FoundationModels

@Generable
enum Topic: CaseIterable, Identifiable {
	case programming
	case travel
	case hobby
	case football
	case music
	case art
	case science
	case food
	case movies
	case technology
	
	var id: Self { self }
	
	var name: String {
		switch self {
		case .programming: return "Programming"
		case .travel:      return "Travel"
		case .hobby:       return "Hobby"
		case .football:    return "Football"
		case .music:       return "Music"
		case .art:         return "Art"
		case .science:     return "Science"
		case .food:        return "Food"
		case .movies:      return "Movies"
		case .technology:  return "Technology"
		}
	}
	
	var icon: String {
		switch self {
		case .programming: return "chevron.left.slash.chevron.right" // SF Symbol for code
		case .travel:      return "airplane"
		case .hobby:       return "puzzlepiece"
		case .football:    return "soccerball"
		case .music:       return "music.note"
		case .art:         return "paintpalette"
		case .science:     return "atom"
		case .food:        return "fork.knife"
		case .movies:      return "film"
		case .technology:  return "desktopcomputer"
		}
	}
}

@Generable
enum nLevel: String, CaseIterable, Identifiable {
	case N5
	case N4
	case N3
	case N2
	case N1
	
	var id : String {
		self.rawValue
	}
	
	var color: Color {
		switch self {
		case .N5:
			return .red
		case .N4:
			return .orange
		case .N3:
			return .yellow
		case .N2:
			return .green
		case .N1:
			return .blue
		}
	}
	
	var icon: String {
		switch self {
		case .N5:
			return "5.circle.fill"
		case .N4:
			return "4.circle.fill"
		case .N3:
			return "3.circle.fill"
		case .N2:
			return "2.circle.fill"
		case .N1:
			return "1.circle.fill"
		}
	}
}

@Generable
struct SentenceModel: Identifiable {
	var id: String = UUID().uuidString
	
	var level: nLevel
	
	var japanese: String
	var english: String
	var romanized: String
	
}

@Generable
enum AISentenceRating: String, CaseIterable {
	case good
	case bad
	case mixed
	
	
	var color: Color {
		switch self {
		case .good:
			return .green
		case .bad:
			return .red
		case .mixed:
			return .yellow
		}
	}
	
	var icon: String {
		switch self {
		case .good:
			return "checkmark.circle.fill"
		case .bad:
			return "xmark.circle.fill"
		case .mixed:
			return "exclamationmark.triangle.fill"
		}
	}
	var asText: String {
		switch self {
		case .good:
			return "Good"
		case .bad:
			return "Bad"
		case .mixed:
			return "Mixed"
		}
	}
}

@Generable
struct AISentenceResponse {
	var rating: AISentenceRating
	
	@Guide(description: "Your confidence in the answer")
	var confidence: Double = 0.0
	var explanation: String
	var corrected: String?
	var suggestions: [String] = []
	
}

extension AISentenceResponse {
	static let sample: AISentenceResponse = AISentenceResponse(
		rating: .good,
		confidence: 0.9,
		explanation: "This is correct.",
		corrected: nil,
		suggestions: []
	)
}


extension SentenceModel {
	static let samples: [SentenceModel] = [
		SentenceModel(
			level: .N5,
			japanese: "わたしは学生です。",
			english: "I am a student.",
			romanized: "Watashi wa gakusei desu."
		),
		SentenceModel(
			level: .N5,
			japanese: "これは本です。",
			english: "This is a book.",
			romanized: "Kore wa hon desu."
		),
		SentenceModel(
			level: .N4,
			japanese: "毎日、日本語を勉強します。",
			english: "I study Japanese every day.",
			romanized: "Mainichi, nihongo o benkyou shimasu."
		),
		SentenceModel(
			level: .N4,
			japanese: "昨日、友達と映画を見ました。",
			english: "Yesterday, I watched a movie with my friend.",
			romanized: "Kinou, tomodachi to eiga o mimashita."
		),
		SentenceModel(
			level: .N3,
			japanese: "雨が降っているので、傘を持って行きます。",
			english: "Since it’s raining, I’ll take an umbrella.",
			romanized: "Ame ga futte iru node, kasa o motte ikimasu."
		),
		SentenceModel(
			level: .N3,
			japanese: "彼は日本に三年間住んでいました。",
			english: "He lived in Japan for three years.",
			romanized: "Kare wa nihon ni san nenkan sunde imashita."
		),
		SentenceModel(
			level: .N2,
			japanese: "この問題は簡単そうに見えるが、実は難しい。",
			english: "This problem looks easy, but it’s actually difficult.",
			romanized: "Kono mondai wa kantan sou ni mieru ga, jitsu wa muzukashii."
		),
		SentenceModel(
			level: .N2,
			japanese: "彼女は医者になるために、一生懸命勉強している。",
			english: "She is studying hard to become a doctor.",
			romanized: "Kanojo wa isha ni naru tame ni, isshoukenmei benkyou shite iru."
		),
		SentenceModel(
			level: .N1,
			japanese: "環境問題は私たち全員が取り組むべき課題です。",
			english: "Environmental issues are challenges we all should address.",
			romanized: "Kankyou mondai wa watashitachi zen’in ga torikumu beki kadai desu."
		),
		SentenceModel(
			level: .N1,
			japanese: "彼の意見は非常に説得力がありました。",
			english: "His opinion was very persuasive.",
			romanized: "Kare no iken wa hijou ni settokuryoku ga arimashita."
		)
	]
}
