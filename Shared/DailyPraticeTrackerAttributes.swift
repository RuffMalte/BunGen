//
//  DailyPraticeTrackerAttributes.swift
//  BunGen
//
//  Created by Malte Ruff on 26.06.25.
//
import ActivityKit
import Foundation

struct DailyPraticeTrackerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var activeTodoTitle: String?
        var elapsedTime: TimeInterval
        var isRunning: Bool
		var todos: [DailyPraticeTodoItemModel]
    }
    
    var id: UUID
}

struct DailyPraticeTodoItemModel: Identifiable, Codable, Hashable {
	var id: UUID = UUID()
	var title: String
	var isCompleted: Bool
	var timeSpent: TimeInterval = 0
}
