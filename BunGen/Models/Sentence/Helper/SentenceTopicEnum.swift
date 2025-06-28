//
//  SentenceTopicEnum.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//


import SwiftUI
import FoundationModels

@Generable
enum SentenceTopicEnum: CaseIterable, Identifiable {
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