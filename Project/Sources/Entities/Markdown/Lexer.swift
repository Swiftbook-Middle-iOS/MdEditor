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

final class Lexer {
	func tokenize(_ input: String) -> [Token] {
		let lines = input.components(separatedBy: .newlines)
		var tokens = [Token?]()

		for line in lines {
			tokens.append(parseLineBreak(rawText: line))
			tokens.append(parseHeader(rawText: line))
			tokens.append(parseBlockquote(rawText: line))
			tokens.append(parseParagraph(rawText: line))
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
		let regex = /^(?<headerLevel>#{1,6})\s+(?<headerText>.+)/

		if let match = rawText.wholeMatch(of: regex) {
			let headerLevel = String(match.headerLevel).count
			let headerText = String(match.headerText)
			return .header(level: headerLevel, text: parseText(rawText: headerText))
		}

		return nil
	}

	func parseBlockquote(rawText: String) -> Token? {
		let regex = /^(>{1,6})\s+(.+)/

		if let match = rawText.wholeMatch(of: regex) {
			let blockquoteLevel = String(match.output.1).count
			let blockquoteText = parseText(rawText: String(match.output.2))
			return .blockquote(level: blockquoteLevel, text: blockquoteText)
		}

		return nil
	}

	func parseParagraph(rawText: String) -> Token? {
		if rawText.isEmpty { return nil }
		let regex = /^([^#>].*)/

		if let match = rawText.wholeMatch(of: regex) {
			let paragraphText = parseText(rawText: String(match.output.1))
			return .paragraph(text: paragraphText)
		}

		return nil
	}

	func parseText(rawText: String) -> Text {
		TextParser().parse(rawText: rawText)
	}
}

// swiftlint:enable opening_brace
