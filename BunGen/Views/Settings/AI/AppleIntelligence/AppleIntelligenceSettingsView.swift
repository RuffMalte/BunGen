//
//  AppleIntelligenceSettingsView.swift
//  BunGen
//
//  Created by Malte Ruff on 25.06.25.
//

import SwiftUI

struct AppleIntelligenceSettingsView: View {
    var body: some View {
		Form {
			
			
		}
		.overlay {
			VStack {
				Spacer()
				GenerativeViewAvailabilityView()
			}
		}
    }
}

#Preview {
    AppleIntelligenceSettingsView()
}
