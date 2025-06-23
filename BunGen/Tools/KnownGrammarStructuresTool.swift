//
//  KnownGrammarStructuresTool.swift
//  BunGen
//
//  Created by Malte Ruff on 23.06.25.
//

import Foundation
import FoundationModels

struct KnownGrammarStructuresTool: Tool {

	
	let name: String = "known-grammar-structures"
	let description: String = "Generates a list of all known grammar structures to the current user. Wich"
	
	@Generable
	struct Arguments {
		@Guide(description: "The level of the grammar structures to get", .range(1...5))
		var jlptLevel: Int?
	}
	
	
	func call(arguments: Arguments) async throws -> ToolOutput {
		var allStructures: [String] = []
		
		allStructures = jlptN5Grammar
		
		
		print("Called tool: " + name)
		
		
		let formattedOutput: String = allStructures.joined(separator: "\n")
		
		return ToolOutput(formattedOutput)
		
	}
		
		
}

let jlptN5Grammar: [String] = [
	"です",             // copula (to be)
	"だ",               // plain copula
	"ます",             // polite verb ending
	"ません",           // negative polite verb ending
	"ました",           // past polite verb ending
	"ませんでした",     // past negative polite verb ending
	"が",               // subject marker / but
	"は",               // topic marker
	"を",               // object marker
	"に",               // location/time/indirect object marker
	"で",               // location of action / means
	"へ",               // direction marker
	"の",               // possessive/nominalizer
	"も",               // also, too
	"と",               // and, with
	"や",               // and (non-exhaustive)
	"から",             // from, because
	"まで",             // until, as far as
	"より",             // than
	"だけ",             // only
	"くらい",           // about, approximately
	"ぐらい",           // about, approximately
	"でしょう",         // probably, I think
	"だろう",           // probably (plain)
	"か",               // question particle
	"ね",               // sentence-ending particle (seeking confirmation)
	"よ",               // sentence-ending particle (assertion)
	"もう",             // already
	"まだ",             // still, not yet
	"〜たい",           // want to do (verb stem + tai)
	"〜たくない",       // do not want to do
	"〜たかった",       // wanted to do
	"〜たくなかった",   // did not want to do
	"〜てください",     // please do (te-form + kudasai)
	"〜てもいい",       // it's okay to do
	"〜てはいけない",   // must not do
	"〜ている",         // is/are/am doing (progressive/continuous)
	"〜ていない",       // is not doing
	"〜てから",         // after doing
	"〜たり〜たりする", // do things like A and B
	"〜たことがある",   // have done before
	"〜ないでください", // please don't do
	"〜なければならない", // must do (formal)
	"〜なくてはいけない", // must do (formal)
	"〜なければいけない", // must do (formal)
	"〜なくてもいい",   // don't have to do
	"〜ませんか",       // won't you, shall we
	"〜ましょう",       // let's do
	"〜ましょうか",     // shall I/we
	"〜つもり",         // intend to do
	"〜に行く",         // go to do (verb stem + ni iku)
	"〜に来る",         // come to do (verb stem + ni kuru)
	"〜にする",         // to decide on
	"〜のが好き",       // like doing
	"〜のが上手",       // good at doing
	"〜のが下手",       // bad at doing
	"〜前に",           // before doing
	"〜後で",           // after doing
	"〜方",             // way of doing (verb stem + kata)
	"〜すぎる",         // too much (verb stem + sugiru)
	"〜やすい",         // easy to do (verb stem + yasui)
	"〜にくい",         // hard to do (verb stem + nikui)
	"〜ことができる",   // can do (potential form)
	"〜ほうがいい",     // it is better to
	"〜ないほうがいい", // it is better not to
	"〜でしょうか",     // I wonder if (polite question)
	"〜だけでなく",     // not only ... but also
	"〜しか〜ない",     // nothing but, only
	"〜ても",           // even if
	"〜ながら",         // while doing
	"〜ので",           // because, since
	"〜こと",           // nominalizer (turns verbs into nouns)
	"〜ことがある",     // have the experience of
	"〜ことにする",     // decide to do
	"〜ことになる",     // it has been decided
	"〜そうです",       // it looks like, I heard that
	"〜ようです",       // it seems that
	"〜みたい",         // looks like, seems (casual)
	"〜たら",           // if, when (conditional)
	"〜ば",             // if (conditional)
	"〜う",             // volitional form (plain let's)
	"〜な",             // don't do (prohibitive, plain)
	"〜なあ",           // sentence-ending particle (emotion, admiration)
	"〜でしょう",       // probably, I suppose (polite)
	"〜かどうか",       // whether or not
	"〜たり",           // do things like
	"〜や",             // and (non-exhaustive)
	"〜も",             // also, too
	"〜しか",           // only (with negative)
	"〜でも",           // even, but
	"〜とき",           // when
	"〜ながら",         // while
	"〜あまり〜ない"    // not very much
]
