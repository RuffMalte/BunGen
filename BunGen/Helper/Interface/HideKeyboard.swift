//
//  HideKeyboard.swift
//  BunGen
//
//  Created by Malte Ruff on 27.06.25.
//

import SwiftUI


func hideKeyboard() {
	UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
