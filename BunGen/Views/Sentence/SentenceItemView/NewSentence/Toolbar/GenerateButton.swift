//
//  GenerateButton.swift
//  BunGen
//
//  Created by Malte Ruff on 28.06.25.
//
import SwiftUI

struct GenerateButton: View {
    @Binding var isAnswering: Bool
    let action: () -> Void
    
    var body: some View {
        Button(role: .confirm, action: action) {
            Image(systemName: "apple.intelligence")
                .contentTransition(.symbolEffect(.automatic))
                .symbolEffect(
                    .rotate.byLayer,
                    options: isAnswering ? .repeat(.periodic(delay: 0.0)) : .default,
                    value: isAnswering
                )
        }
        .disabled(isAnswering)
    }
}
