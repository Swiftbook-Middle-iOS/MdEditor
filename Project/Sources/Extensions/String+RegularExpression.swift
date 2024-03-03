//
//  String+RegularExpression.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 20.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

extension String {
	func group(for regexPattern: String) -> String? {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let range = NSRange(location: .zero, length: text.utf16.count)

			if let match = regex.firstMatch(in: text, range: range),
			   let group = Range(match.range(at: 1), in: text) {
				return String(text[group])
			}
		} catch _ as NSError {
		}

		return nil
	}
}
