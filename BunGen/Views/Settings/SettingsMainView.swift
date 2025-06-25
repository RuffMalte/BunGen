//
//  SettingsMainView.swift
//  BunGen
//
//  Created by Malte Ruff on 25.06.25.
//

import SwiftUI

struct SettingsMainView: View {
    var body: some View {
		NavigationStack {
			Form {
				
				Section {
					SettingsItemListView(
						icon: "apple.intelligence",
						iconBackground: .red,
						title: "Apple Intelligence",
						navigationDestination: AnyView(AppleIntelligenceSettingsView())
					)
					
					
					
					
				}
				
				
				
			}
			
			
			
		}
    }
}

#Preview {
    SettingsMainView()
}
