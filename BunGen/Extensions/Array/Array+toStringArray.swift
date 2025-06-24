//
//  Array+toStringArray.swift
//  BunGen
//
//  Created by Malte Ruff on 24.06.25.
//

import Foundation

extension Array {
	/// Converts array elements to string representations using a custom transform
	func toStringArray(using transform: (Element) -> String) -> [String] {
		return self.map(transform)
	}
}
