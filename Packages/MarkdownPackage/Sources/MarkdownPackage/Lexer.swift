//
//  Lexer.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 20.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
// swiftlint:disable opening_brace

import Foundation

protocol ILexer {
	func tokenize(_ input: String) -> [Token]
}

public final class Lexer {
	public init() {}

	public func tokenize(_ input: String) -> [Token] {
		let lines = input.components(separatedBy: .newlines)
		var tokens = [Token?]()
		var inCodeBlock = false

		for line in lines {
			if let codeBlockToken = parseCodeBlockMarker(rawText: line) {
				tokens.append(codeBlockToken)
				inCodeBlock.toggle()
				continue
			}

			if !inCodeBlock {
				tokens.append(parseLineBreak(rawText: line))
				tokens.append(parseHeader(rawText: line))
				tokens.append(parseBlockquote(rawText: line))
				tokens.append(parseParagraph(rawText: line))
			} else {
				tokens.append(.codeLine(text: line))
			}
		}

		return tokens.compactMap { $0 }
	}
}

private extension Lexer {
	func parseLineBreak(rawText: String) -> Token? {
		if rawText.isEmpty {
			return .lineBreak
		}

		return nil
	}

	func parseHeader(rawText: String) -> Token? {
		let regex = #/^(?<headerLevel>#{1,6})\s+(?<headerText>.+)/#

		if let match = rawText.wholeMatch(of: regex) {
			let headerLevel = String(match.headerLevel).count
			let headerText = String(match.headerText)
			return .header(level: headerLevel, text: parseText(rawText: headerText))
		}

		return nil
	}

	func parseBlockquote(rawText: String) -> Token? {
		let regex = #/^(>{1,6})\s+(.+)/#

		if let match = rawText.wholeMatch(of: regex) {
			let blockquoteLevel = String(match.output.1).count
			let blockquoteText = parseText(rawText: String(match.output.2))
			return .blockquote(level: blockquoteLevel, text: blockquoteText)
		}

		return nil
	}

	func parseParagraph(rawText: String) -> Token? {
		if rawText.isEmpty { return nil }
		let regex = #/^([^#>].*)/#

		if let match = rawText.wholeMatch(of: regex) {
			let paragraphText = parseText(rawText: String(match.output.1))
			return .textLine(text: paragraphText)
		}

		return nil
	}

	func parseCodeBlockMarker(rawText: String) -> Token? {
		let pattern = #"^`{2,6}(.*)"#

		if let text = rawText.group(for: pattern) {
			let level = rawText.filter { $0 == "`" }.count
			return .codeBlockMarker(level: level, lang: text)
		}

		return nil
	}

	func parseText(rawText: String) -> Text {
		TextParser().parse(rawText: rawText)
	}
}

// swiftlint:enable opening_brace
