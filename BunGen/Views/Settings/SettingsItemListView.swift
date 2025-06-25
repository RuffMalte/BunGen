//
//  SettingsItemListView.swift
//  BunGen
//
//  Created by Malte Ruff on 25.06.25.
//

import SwiftUI

struct SettingsItemListView: View {
	
	var icon: String
	var iconBackground: Color
	var title: String
	var navigationDestination: AnyView
	
	var body: some View {
		NavigationLink {
			navigationDestination
		} label: {
			HStack {
				ZStack {
					RoundedRectangle(cornerRadius: 8)
						.foregroundStyle(iconBackground)
						.frame(width: 40, height: 40)
					Image(systemName: icon)
						.foregroundStyle(.white)
						.font(.title3)
				}
				
				
				Text(title)
			}
		}
		.buttonStyle(.plain)
		
		
	}
}
