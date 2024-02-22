//
//  TextParser.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 20.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

// TODO: remove public
public final class TextParser {
	public init() {}
	private struct PartRegex {
		let type: PartType
		let regex: NSRegularExpression

		enum PartType: String {
			case normal
			case bold
			case italic
			case boldItalic
			case inlineCode
			case escapedChar
			case link
		}

		init(type: TextParser.PartRegex.PartType, pattern: String) {
			self.type = type
			self.regex = try! NSRegularExpression(pattern: pattern) // swiftlint:disable:this force_try
		}
	}

	private let partRegexes = [
		PartRegex(type: .escapedChar, pattern: #"^\\([\\\`\*\_\{\}\[\]\<\>\(\)\+\-\.\!\|#]){1}"#),
		PartRegex(type: .link, pattern: #"\[((?:[^\]]|\](?=[^\[]*\]))+)\]\((\S+)\)"#),
		PartRegex(type: .normal, pattern: #"^(.*?)(?=[\*`\\]|$)"#),
		PartRegex(type: .boldItalic, pattern: #"^\*\*\*(.*?)\*\*\*"#),
		PartRegex(type: .bold, pattern: #"^\*\*(.*?)\*\*"#),
		PartRegex(type: .italic, pattern: #"^\*(.*?)\*"#),
		PartRegex(type: .inlineCode, pattern: #"^`(.*?)`"#)
	]

	public func parse(rawText text: String) -> Text {
		var parts = [Text.Part]()
		var range = NSRange(text.startIndex..., in: text)

		while range.location != NSNotFound && range.length != 0 {
			let startPartsCount = parts.count
			for partRegex in partRegexes {
				if let match = partRegex.regex.firstMatch(in: text, range: range),
				   let group0 = Range(match.range(at: 0), in: text),
				   let group1 = Range(match.range(at: 1), in: text) {

					let extractedText = String(text[group1])
					if !extractedText.isEmpty {
						switch partRegex.type {
						case .normal:
							parts.append(.normal(text: extractedText))
						case .bold:
							parts.append(.bold(text: extractedText))
						case .italic:
							parts.append(.italic(text: extractedText))
						case .boldItalic:
							parts.append(.boldItalic(text: extractedText))
						case .inlineCode:
							parts.append(.inlineCode(text: extractedText))
						case .escapedChar:
							parts.append(.escapedChar(text: extractedText))
						case .link:
							if let group2 = Range(match.range(at: 2), in: text) {
								parts.append(.link(url: String(text[group2]), text: extractedText))
							}
						}
						range = NSRange(group0.upperBound..., in: text)
						break
					}
				}
			}
			if parts.count == startPartsCount {
				let extractedText = String(text[Range(range, in: text)!]) // swiftlint:disable:this force_unwrapping
				parts.append(.normal(text: extractedText))
				break
			}
		}

		return Text(text: parts)
	}
}
