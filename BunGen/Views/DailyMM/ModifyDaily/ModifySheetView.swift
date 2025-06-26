//
//  ModifySheetView.swift
//  BunGen
//
//  Created by Malte Ruff on 26.06.25.
//

import SwiftUI
import Combine

struct ModifySheetView: View {
	
	@State private var viewModel = DailyPraticeTrackerViewModel()


	
	var body: some View {
		NavigationStack {
			VStack(spacing: 20) {
				// Timer display
				Text(viewModel.formattedTime(viewModel.elapsedTime))
					.font(.system(size: 48, weight: .bold))
					.monospacedDigit()
				
				// Timer controls
				HStack(spacing: 40) {
					Button(action: viewModel.startTimer) {
						Image(systemName: "play.fill")
							.padding(20)
							.background(Circle().fill(Color.green))
					}
					.disabled(viewModel.activeTodo == nil || viewModel.isTimerRunning)
					
					Button(action: viewModel.stopTimer) {
						Image(systemName: "stop.fill")
							.padding(20)
							.background(Circle().fill(Color.red))
					}
					.disabled(!viewModel.isTimerRunning)
				}
				.foregroundColor(.white)
				.font(.title)
				
				// Todo list
				List {
					ForEach($viewModel.todos) { $todo in
						HStack {
							Button(action: { viewModel.completeTodo(todo) }) {
								Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
									.foregroundColor(todo.isCompleted ? .green : .primary)
							}
							
							Text(todo.title)
								.strikethrough(todo.isCompleted)
							
							Spacer()
							
							if viewModel.activeTodo?.id == todo.id {
								Image(systemName: "clock")
									.foregroundColor(.blue)
							}
							
							Text(viewModel.formattedTime(todo.timeSpent))
								.monospacedDigit()
								.frame(width: 80)
						}
						.onTapGesture {
							viewModel.setActiveTodo(todo)
						}
					}
				}
				.listStyle(.plain)
			}
			.padding()
			.navigationTitle("Todo Tracker")
//			.onDisappear {
//				viewModel.stopTimer()
//				viewModel.endLiveActivity()
//			}
		}
	}
}

#Preview {
    ModifySheetView()
}
