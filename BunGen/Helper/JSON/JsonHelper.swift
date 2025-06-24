//
//  JsonHelper.swift
//  BunGen
//
//  Created by Malte Ruff on 24.06.25.
//

import Foundation

class JsonHelper {
	/// let user: User = try decodeJSON(from: "/path/to/user.json", as: User.self)
	func decodeJSON<T: Decodable>(from resource: String, as type: T.Type) throws -> T {
		let url: URL
		if let dotIndex = resource.lastIndex(of: ".") {
			let name = String(resource[..<dotIndex])
			let ext = String(resource[resource.index(after: dotIndex)...])
			guard let bundleURL = Bundle.main.url(forResource: name, withExtension: ext) else {
				throw NSError(domain: "JsonHelper", code: 1, userInfo: [NSLocalizedDescriptionKey: "Resource \(resource) not found in bundle"])
			}
			url = bundleURL
		} else {
			guard let bundleURL = Bundle.main.url(forResource: resource, withExtension: nil) else {
				throw NSError(domain: "JsonHelper", code: 1, userInfo: [NSLocalizedDescriptionKey: "Resource \(resource) not found in bundle"])
			}
			url = bundleURL
		}
		let data = try Data(contentsOf: url)
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	}
	
	
	///	// 1. Filter players with level == 9
	///	let level9Players = try filterJSON(
	///		from: "/path/to/players.json",
	///		as: [Player].self
	///	) { $0.level == 9 }
	///
	///	// 2. Filter players with levels 7-9
	///	let midLevelPlayers = try filterJSON(
	///		from: "/path/to/players.json",
	///		as: [Player].self
	///	) { (7...9).contains($0.level) }
	///
	///	// 3. Filter by string property
	///	let specificPlayers = try filterJSON(
	///		from: "/path/to/players.json",
	///		as: [Player].self
	///	) { $0.name.hasPrefix("A") }
	func filterJSON<T: Decodable>(
		from resource: String,
		as type: T.Type,
		where predicate: (T) -> Bool
	) throws -> [T] {
		if let array = try? decodeJSON(from: resource, as: [T].self) {
			return array.filter(predicate)
		}
		else if let singleObject = try? decodeJSON(from: resource, as: T.self) {
			return predicate(singleObject) ? [singleObject] : []
		}
		return []
	}
}
