//
//  KnownVocabularyTool.swift
//  BunGen
//
//  Created by Malte Ruff on 23.06.25.
//

import Foundation
import FoundationModels


struct KnownVocabularyTool: Tool {

	
	
	let name: String = "known-vocabulary"
	let description: String = "Generates a list of all known vocabulary terms."
	
	@Generable
	struct Arguments {
		@Guide(description: "The level of the vocabulary to get", .range(1...5))
		var JLPTLevel: Int
	}
	
	
	func call(arguments: Arguments) async throws -> ToolOutput {
		
		var knownVocabulary: [String] = []
		
		knownVocabulary = jlptN5Vocabulary
		
		print("Called tool: " + arguments.JLPTLevel.description)
		
		let formattedOutput: String = knownVocabulary.joined(separator: "\n")
		
		return ToolOutput(formattedOutput)
	}
}


let jlptN5Vocabulary: [String] = [
	"会う",    // to meet
	"青",      // blue
	"赤",      // red
	"明るい",  // bright
	"秋",      // autumn
	"開く",    // to open (intransitive)
	"開ける",  // to open (transitive)
	"上げる",  // to give
	"朝",      // morning
	"朝ご飯",  // breakfast
	"足",      // foot, leg
	"明日",    // tomorrow
	"遊ぶ",    // to play
	"暖かい",  // warm
	"頭",      // head
	"新しい",  // new
	"暑い",    // hot (weather)
	"甘い",    // sweet
	"雨",      // rain
	"歩く",    // to walk
	"いい",    // good
	"家",      // house, home
	"行く",    // to go
	"池",      // pond
	"医者",    // doctor
	"椅子",    // chair
	"忙しい",  // busy
	"痛い",    // painful
	"一",      // one
	"五",      // five
	"犬",      // dog
	"今",      // now
	"意味",    // meaning
	"妹",      // younger sister
	"入口",    // entrance
	"居る",    // to exist (animate)
	"色",      // color
	"映画",    // movie
	"駅",      // station
	"鉛筆",    // pencil
	"大きい",  // big
	"多い",    // many
	"お母さん",// mother
	"お金",    // money
	"起きる",  // to get up
	"教える",  // to teach
	"男",      // man
	"女",      // woman
	"音楽",    // music
	"買う",    // to buy
	"学校",    // school
	"学生",    // student
	"傘",      // umbrella
	"風",      // wind
	"家族",    // family
	"川",      // river
	"漢字",    // kanji
	"聞く",    // to listen, to ask
	"牛乳",    // milk
	"今日",    // today
	"教室",    // classroom
	"兄",      // older brother
	"姉",      // older sister
	"国",      // country
	"黒",      // black
	"警察",    // police
	"今月",    // this month
	"魚",      // fish
	"仕事",    // work
	"辞書",    // dictionary
	"静か",    // quiet
	"下",      // under, below
	"自転車",  // bicycle
	"新聞",    // newspaper
	"水",      // water
	"好き",    // like
	"少し",    // a little
	"先生",    // teacher
	"全部",    // all
	"外",      // outside
	"空",      // sky
	"食べる",  // to eat
	"友達",    // friend
	"父",      // father
	"使う",    // to use
	"机",      // desk
	"手紙",    // letter
	"天気",    // weather
	"電話",    // telephone
	"時計",    // clock, watch
	"友達",    // friend
	"名前",    // name
	"西",      // west
	"猫",      // cat
	"飲む",    // to drink
	"白",      // white
	"半",      // half
	"昼",      // noon
	"勉強",    // study
	"本",      // book
	"毎日",    // every day
	"町",      // town
	"見せる",  // to show
	"見る",    // to see
	"耳",      // ear
	"持つ",    // to hold
	"門",      // gate
	"休む",    // to rest
	"来る",    // to come
	"冷たい",  // cold (to the touch)
	"話す",    // to speak
	"分かる",  // to understand
	"私",      // I, me
	"渡す"     // to hand over
]
