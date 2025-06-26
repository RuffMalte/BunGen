//
//  DailyPraticeTrackerActivity.swift
//  BunGen
//
//  Created by Malte Ruff on 26.06.25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DailyPraticeTrackerActivity: Widget {
	var body: some WidgetConfiguration {
		ActivityConfiguration(for: DailyPraticeTrackerAttributes.self) { context in
			HStack(spacing: 10) {
				let completed = context.state.todos.filter { $0.isCompleted }.count
				let total = context.state.todos.count
				let progress = total > 0 ? Double(completed) / Double(total) : 0.0
				
				Gauge(value: progress) {
				}
				.gaugeStyle(.accessoryCircularCapacity)
				.tint(progress == 1.0 ? .green : .blue)
				
				VStack(alignment:.leading) {
					if let todoTitle = context.state.activeTodoTitle {
						Text(todoTitle)
							.font(.headline)
					} else {
						Text("No active task")
							.font(.headline)
							.foregroundColor(.secondary)
					}
					
					HStack {
						Text(formattedTime(context.state.elapsedTime))
							.font(.title)
							.monospacedDigit()
						
						Spacer()
						
						Image(systemName: context.state.isRunning ? "play.fill" : "pause.fill")
							.foregroundColor(context.state.isRunning ? .green : .orange)
					}
				}
			}
			.padding()
			.activityBackgroundTint(Color.cyan.opacity(0.2))
		} dynamicIsland: { context in
			DynamicIsland {
				DynamicIslandExpandedRegion(.leading) {
					Text("Practice Tracker")
						.font(.caption)
				}
				DynamicIslandExpandedRegion(.trailing) {
					Text(formattedTime(context.state.elapsedTime))
						.monospacedDigit()
				}
				DynamicIslandExpandedRegion(.bottom) {
					if let todoTitle = context.state.activeTodoTitle {
						Text(todoTitle)
							.lineLimit(1)
					}
				}
			} compactLeading: {
				let completed = context.state.todos.filter { $0.isCompleted }.count
				let total = context.state.todos.count
				let progress = total > 0 ? Double(completed) / Double(total) : 0.0
				
				Gauge(value: progress) {
				}
				.gaugeStyle(.accessoryCircularCapacity)
				.tint(progress == 1.0 ? .green : .blue)
			} compactTrailing: {
				Text(formattedTime(context.state.elapsedTime))
					.monospacedDigit()
					.frame(width: 60)
			} minimal: {
				let completed = context.state.todos.filter { $0.isCompleted }.count
				let total = context.state.todos.count
				let progress = total > 0 ? Double(completed) / Double(total) : 0.0
				
				Gauge(value: progress) {
				}
				.gaugeStyle(.accessoryCircularCapacity)
				.tint(progress == 1.0 ? .green : .blue)
			}
			.keylineTint(.blue)
		}
	}
	
	private func formattedTime(_ time: TimeInterval) -> String {
		let minutes = Int(time) / 60
		let seconds = Int(time) % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}
}


#Preview(
	as: .dynamicIsland(.minimal),
	using: DailyPraticeTrackerAttributes.init(id: UUID())
) {
	DailyPraticeTrackerActivity()
} contentStates: {
	DailyPraticeTrackerAttributes
		.ContentState(
			activeTodoTitle: "hello",
			elapsedTime: 123,
			isRunning: true,
			todos: []
		)
}

#Preview(
	as: .dynamicIsland(.compact),
	using: DailyPraticeTrackerAttributes.init(id: UUID())
) {
	DailyPraticeTrackerActivity()
} contentStates: {
	DailyPraticeTrackerAttributes
		.ContentState(
			activeTodoTitle: "hello",
			elapsedTime: 123,
			isRunning: true,
			todos: []
		)
}
#Preview(
	as: .dynamicIsland(.expanded),
	using: DailyPraticeTrackerAttributes.init(id: UUID())
) {
	DailyPraticeTrackerActivity()
} contentStates: {
	DailyPraticeTrackerAttributes
		.ContentState(
			activeTodoTitle: "hello",
			elapsedTime: 123,
			isRunning: true,
			todos: []
		)
}
