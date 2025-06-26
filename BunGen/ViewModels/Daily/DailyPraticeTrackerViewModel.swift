//
//  DailyPraticeTrackerViewModel.swift
//  BunGen
//
//  Created by Malte Ruff on 26.06.25.
//

import Foundation
import ActivityKit
import SwiftUI

@Observable
class DailyPraticeTrackerViewModel {
    // Timer state
    var elapsedTime: TimeInterval = 0
    var isTimerRunning = false
    private var timer: Timer?
    
    // Todo items
    
	var todos: [DailyPraticeTodoItemModel] = [
		DailyPraticeTodoItemModel(title: "Buy groceries", isCompleted: false),
		DailyPraticeTodoItemModel(title: "Walk the dog", isCompleted: false),
		DailyPraticeTodoItemModel(title: "Call mom", isCompleted: false)
    ]
	var completionProgress: Double {
		let total = todos.count
		guard total > 0 else { return 0 }
		let completed = todos.filter { $0.isCompleted }.count
		return Double(completed) / Double(total)
	}
    // Active tracking
    var activeTodo: DailyPraticeTodoItemModel? {
        didSet {
            elapsedTime = 0
            updateLiveActivity()
        }
    }
    
    // Live Activity
    var activity: Activity<DailyPraticeTrackerAttributes>?
    
    // Timer controls
    func startTimer() {
        guard activeTodo != nil else { return }
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.elapsedTime += 1
            self?.updateLiveActivity()
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
        updateLiveActivity()
    }
    
    // Live Activity management
    func startLiveActivity() {
		guard ActivityAuthorizationInfo().areActivitiesEnabled else {
			print("Live Activities disabled in system settings")
			return
		}
        guard activity == nil, let activeTodo else { return }
        
        let attributes = DailyPraticeTrackerAttributes(id: UUID())
        let initialState = DailyPraticeTrackerAttributes.ContentState(
            activeTodoTitle: activeTodo.title,
            elapsedTime: elapsedTime,
            isRunning: isTimerRunning,
			todos: todos
			
        )
        
        do {
            activity = try Activity.request(
                attributes: attributes,
                content: .init(state: initialState, staleDate: nil),
                pushType: nil
            )
        } catch {
            print("Live Activity error: \(error)")
        }
    }
    
    func updateLiveActivity() {
        Task {
            let updatedState = DailyPraticeTrackerAttributes.ContentState(
                activeTodoTitle: activeTodo?.title,
                elapsedTime: elapsedTime,
				isRunning: isTimerRunning,
				todos: todos
            )
            await activity?.update(using: updatedState)
        }
    }
    
    func endLiveActivity() {
        Task {
            let finalState = DailyPraticeTrackerAttributes.ContentState(
                activeTodoTitle: activeTodo?.title,
                elapsedTime: elapsedTime,
                isRunning: false,
				todos: todos

            )
            await activity?.end(using: finalState, dismissalPolicy: .default)
            activity = nil
        }
    }
    
    // Todo actions
    func setActiveTodo(_ todo: DailyPraticeTodoItemModel) {
        if activeTodo?.id == todo.id {
            isTimerRunning ? stopTimer() : startTimer()
        } else {
            stopTimer()
            activeTodo = todo
        }
        startLiveActivity()
    }
    
    func completeTodo(_ todo: DailyPraticeTodoItemModel) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        
        todos[index].isCompleted = true
        todos[index].timeSpent = (todo.id == activeTodo?.id) ? elapsedTime : todo.timeSpent
        
        if activeTodo?.id == todo.id {
            stopTimer()
            endLiveActivity()
            activeTodo = nil
        }
    }
    
    // Helper
    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
