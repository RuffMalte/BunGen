//
//  AlreadyKnownSentencesTool.swift
//  BunGen
//
//  Created by Malte Ruff on 23.06.25.
//

import Foundation
import FoundationModels

struct AlreadyKnownSentencesTool: Tool {
	
	
	let name: String = "already-known-sentences"
	let description: String = "Generates a List of all known sentences."
	
	
	@Generable
	struct Arguments {
		@Guide(description: "The level of Sentence to get in JLPT level", .range(1...5))
		var JLPTLevel: Int
		
		@Guide(description: "The input Japanese sentence to search if it has been created before")
		var japaneseSentence: String
		
		var topic: String
	}
	
	
	
	func call(arguments: Arguments) async throws -> ToolOutput {
		
		var knownVocabulary: [String] = []
		
		knownVocabulary = n5ProgrammingSentences
		
		print("Called tool: " + arguments.japaneseSentence.description)
		
		let formattedOutput: String = knownVocabulary.joined(separator: "\n")
		
		return ToolOutput(formattedOutput)
	}
	
}

let n5ProgrammingSentences: [String] = [
	"私はプログラミングが好きです。",            // I like programming.
	"私はプログラムを勉強しています。",          // I am studying programming.
	"私は毎日プログラムを書きます。",            // I write programs every day.
	"プログラミングは楽しいです。",              // Programming is fun.
	"私は新しい言語を学びます。",                // I learn a new language.
	"コンピューターが好きです。",                // I like computers.
	"私はエラーを直します。",                    // I fix errors.
	"簡単なプログラムを書きます。",              // I write simple programs.
	"私はコードを読みます。",                    // I read code.
	"先生はプログラミングを教えます。",          // The teacher teaches programming.
	"友達とプログラムを作ります。",              // I make programs with my friend.
	"私は毎日勉強します。",                      // I study every day.
	"新しいアプリを作りたいです。",              // I want to make a new app.
	"私はJavaScriptを使います。",                // I use JavaScript.
	"私はPythonが好きです。",                    // I like Python.
	"私はコードを書きます。",                    // I write code.
	"私はプログラムを作ります。",                // I make programs.
	"私は先生に質問します。",                    // I ask the teacher questions.
	"私は本でプログラミングを学びます。",        // I learn programming from a book.
	"私はパソコンを使います。",                  // I use a computer.
	"私は新しいことを学びます。",                // I learn new things.
	"私は毎日パソコンを使います。",              // I use a computer every day.
	"私はエラーが分かります。",                  // I understand errors.
	"私はプログラミングの本を読みます。",        // I read programming books.
	"私は簡単なゲームを作ります。",              // I make simple games.
	"私は毎日コードを書きます。",                // I write code every day.
	"私はプログラムをテストします。",            // I test programs.
	"私は友達に教えます。",                      // I teach my friend.
	"私は新しいプロジェクトを始めます。",        // I start a new project.
	"私は英語でプログラムを書きます。",          // I write programs in English.
	"私は日本語でプログラムを書きます。",        // I write programs in Japanese.
	"私はコードを直します。",                    // I fix code.
	"私は毎日新しいことを学びます。",            // I learn something new every day.
	"私はプログラミングの勉強が好きです。",      // I like studying programming.
	"私は先生と話します。",                      // I talk with the teacher.
	"私は友達と勉強します。",                    // I study with my friend.
	"私は簡単なアプリを作ります。",              // I make a simple app.
	"私は毎日プログラムを作ります。",            // I make programs every day.
	"私は新しいコードを書きます。",              // I write new code.
	"私はインターネットで調べます。",            // I search on the Internet.
	"私はエラーが分かりません。",                // I do not understand errors.
	"私は先生に聞きます。",                      // I ask the teacher.
	"私はパソコンが好きです。",                  // I like computers.
	"私はプログラムを作るのが好きです。",        // I like making programs.
	"私は毎日勉強するのが好きです。",            // I like studying every day.
	"私は新しい友達を作ります。",                // I make new friends.
	"私はプログラミングを始めました。",          // I started programming.
	"私はプログラムを作るのが楽しいです。",      // Making programs is fun.
	"私は毎日プログラミングをします。"           // I program every day.
]
