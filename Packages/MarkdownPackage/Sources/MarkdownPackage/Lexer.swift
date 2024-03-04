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
				tokens.append(parseHorizontalLine(rawText: line))
				tokens.append(parseParagraph(rawText: line))
				tokens.append(parseOrderedList(rawText: line))
				tokens.append(parseUnorderedList(rawText: line))
				tokens.append(parseTask(rawText: line))
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
		let regex = try? NSRegularExpression(pattern: #"^(?<headerLevel>#{1,6})\s+(?<headerText>.+)"#)
		let range = NSRange(rawText.startIndex..., in: rawText)
		let matches = regex?.matches(in: rawText, range: range)

		guard let match = matches?.first else { return nil }

		if let levelRange = Range(match.range(withName: "headerLevel"), in: rawText),
		   let textRange = Range(match.range(withName: "headerText"), in: rawText) {
			let level = String(rawText[levelRange]).count
			let header = String(rawText[textRange])
			return .header(level: level, text: parseText(rawText: header))
		}

		return nil
	}

	func parseBlockquote(rawText: String) -> Token? {
		let regex = try? NSRegularExpression(pattern: #"^(>{1,6})\s+(.+)"#)
		let range = NSRange(rawText.startIndex..., in: rawText)
		guard let match = regex?.firstMatch(in: rawText, range: range) else { return nil }

		if let levelRange = Range(match.range(at: 1), in: rawText),
		   let textRange = Range(match.range(at: 2), in: rawText) {
			let level = String(rawText[levelRange]).count
			let text = String(rawText[textRange])
			return .blockquote(level: level, text: parseText(rawText: text))
		}

		return nil
	}

	func parseParagraph(rawText: String) -> Token? {
		if rawText.isEmpty { return nil }
		let regex = try? NSRegularExpression(pattern: #"^(?!>|\t*\d+\.\s|\t*-\s|#+\s|[*_-]{3,})([^\>].*)"#)

		let range = NSRange(rawText.startIndex..., in: rawText)

		guard let match = regex?.firstMatch(in: rawText, range: range) else { return nil }

		if let textRange = Range(match.range(at: 1), in: rawText) {
			let paragraphText = String(rawText[textRange])
			return .textLine(text: parseText(rawText: paragraphText))
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

	func parseHorizontalLine(rawText: String) -> Token? {
		let pattern = #"^([-*_])(?:\1){2,}[\t ]*$"#

		if let _ = rawText.group(for: pattern) {
			return .horizontalLine
		}

		return nil
	}

	func parseOrderedList(rawText: String) -> Token? {
		let regex = try? NSRegularExpression(pattern: #"^(\t*)(?:[0-9]+)\.\s+(.+)"#)
		let range = NSRange(rawText.startIndex..., in: rawText)

		guard let match = regex?.firstMatch(in: rawText, range: range) else { return nil }

		if let levelRange = Range(match.range(at: 1), in: rawText),
		   let textRange = Range(match.range(at: 2), in: rawText) {
			let level = String(rawText[levelRange]).count
			let text = String(rawText[textRange])

			return .orderedListItem(level: level, text: parseText(rawText: text))
		}

		return nil
	}

	func parseUnorderedList(rawText: String) -> Token? {
		let regex = try? NSRegularExpression(pattern: #"^(?!\d+\.)(\t*)-\s+((?!\[\s*[Xx*]?\]).+)"#)
		let range = NSRange(rawText.startIndex..., in: rawText)

		guard let match = regex?.firstMatch(in: rawText, range: range) else { return nil }

		if let levelRange = Range(match.range(at: 1), in: rawText),
		   let textRange = Range(match.range(at: 2), in: rawText) {
			let level = String(rawText[levelRange]).count
			let text = String(rawText[textRange])

			return .unorderedListItem(level: level, text: parseText(rawText: text))
		}

		return nil
	}

	func parseText(rawText: String) -> Text {
		TextParser().parse(rawText: rawText)
	}

	func parseTask(rawText: String) -> Token? {
		let pattern = #"\s*- \[[ *Xx]\]\s+(.*)"#

		if let text = rawText.group(for: pattern) {
			let isDone = !rawText.contains("- [ ]")
			return .task(isDone: isDone, text: parseText(rawText: text))
		}

		return nil
	}
}

// swiftlint:enable opening_brace
