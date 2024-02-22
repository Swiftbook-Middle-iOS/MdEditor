//
//  Parser.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 20.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

public final class Parser {
	public init() {}

	public func parse(tokens: [Token]) -> Document {
		var tokens = tokens
		var result = [INode]()

		while !tokens.isEmpty {
			var nodes = [INode?]()
			nodes.append(parseHeader(tokens: &tokens))
			nodes.append(parseBlockquote(tokens: &tokens))
			nodes.append(parseImage(tokens: &tokens))
			nodes.append(parseLinebreak(tokens: &tokens))
			nodes.append(parseCodeblock(tokens: &tokens))
			nodes.append(parseOrderedList(tokens: &tokens))
			nodes.append(parseUnorderedList(tokens: &tokens))
			nodes.append(parseParagraph(tokens: &tokens))

			let resultNodes = nodes.compactMap { $0 }
			if resultNodes.isEmpty, !tokens.isEmpty {
				tokens.removeFirst()
			} else {
				result.append(contentsOf: resultNodes)
			}
		}

		return Document(result)
	}
}

private extension Parser {
	func parseHeader(tokens: inout [Token]) -> HeaderNode? {
		guard let token = tokens.first else { return nil }

		if case let .header(level, text) = token {
			tokens.removeFirst()
			return HeaderNode(level: level, children: parseText(text: text))
		}

		return nil
	}

	func parseBlockquote(tokens: inout [Token]) -> BlockquoteNode? {
		guard let token = tokens.first else { return nil }

		if case let .blockquote(level, text) = token {
			tokens.removeFirst()
			return BlockquoteNode(level: level, parseText(text: text))
		}

		return nil
	}

	func parseParagraph(tokens: inout [Token]) -> ParagraphNode? {
		var textNodes = [INode]()

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }

			if case let .textLine(text) = token {
				tokens.removeFirst()
				textNodes.append(contentsOf: parseText(text: text))
			} else {
				break
			}
		}

		if !textNodes.isEmpty {
			return ParagraphNode(textNodes)
		}

		return nil
	}

	func parseOrderedList(tokens: inout [Token]) -> OrderedListNode? {
		var itemNodes = [INode?]()
		var listLevel: Int!

		guard let token = tokens.first else { return nil }

		if case let .orderedListItem(level, text) = token {
			tokens.removeFirst()
			itemNodes.append(OrderedListItemNode(parseText(text: text)))
			listLevel = level
		} else {
			return nil
		}

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }

			if case let .orderedListItem(level, text) = token {
				if level == listLevel {
					tokens.removeFirst()
					itemNodes.append(OrderedListItemNode(parseText(text: text)))
				} else if level < listLevel {
					break
				} else {
					itemNodes.append(parseOrderedList(tokens: &tokens))
				}
			} else {
				break
			}
		}

		if !itemNodes.isEmpty {
			return OrderedListNode(level: listLevel, children: itemNodes.compactMap { $0 })
		}

		return nil
	}

	func parseUnorderedList(tokens: inout [Token]) -> UnorderedListNode? {
		var itemNodes = [INode?]()
		var listLevel: Int!

		guard let token = tokens.first else { return nil }

		if case let .unorderedListItem(level, text) = token {
			tokens.removeFirst()
			itemNodes.append(UnorderedListItemNode(parseText(text: text)))
			listLevel = level
		} else {
			return nil
		}

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }

			if case let .unorderedListItem(level, text) = token {
				if level == listLevel {
					tokens.removeFirst()
					itemNodes.append(UnorderedListItemNode(parseText(text: text)))
				} else if level < listLevel {
					break
				} else {
					itemNodes.append(parseUnorderedList(tokens: &tokens))
				}
			} else {
				break
			}
		}

		if !itemNodes.isEmpty {
			return UnorderedListNode(level: listLevel, children: itemNodes.compactMap { $0 })
		}

		return nil
	}

	func parseImage(tokens: inout [Token]) -> ImageNode? {
		guard let token = tokens.first else { return nil }

		if case let .image(url, size) = token {
			tokens.removeFirst()
			return ImageNode(url: url, size: size)
		}

		return nil
	}

	func parseLinebreak(tokens: inout [Token]) -> LinebreakNode? {
		guard let token = tokens.first else { return nil }

		if case .lineBreak = token {
			tokens.removeFirst()
			return LinebreakNode()
		}

		return nil
	}

	func parseCodeblock(tokens: inout [Token]) -> CodeblockNode? {
		guard let token = tokens.first else { return nil }

		if case let .codeBlockMarker(level, lang) = token {
			tokens.removeFirst()
			return CodeblockNode(level: level, lang: lang, children: parseCodelines(tokens: &tokens) ?? [])
		}

		return nil
	}

	func parseCodelines(tokens: inout [Token]) -> [CodelineNode]? {
		var codeNodes = [CodelineNode]()

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }

			if case let .codeLine(text) = token {
				tokens.removeFirst()
				codeNodes.append(CodelineNode(code: text))
			} else if case .codeBlockMarker(level: _, lang: _) = token {
				tokens.removeFirst()
				break
			} else {
				break
			}
		}

		if !codeNodes.isEmpty {
			return codeNodes
		}

		return nil
	}

	func parseText(text: Text) -> [INode] {
		var textNodes = [INode]()

		text.text.forEach { part in
			switch part {
			case .normal(let text):
				textNodes.append(TextNode(text: text))
			case .bold(let text):
				textNodes.append(BoldTextNode(text: text))
			case .italic(let text):
				textNodes.append(ItalicTextNode(text: text))
			case .boldItalic(let text):
				textNodes.append(BoldItalicTextNode(text: text))
			case .inlineCode(let text):
				textNodes.append(InlineCodeNode(code: text))
			case .escapedChar(let text):
				textNodes.append(EscapedCharNode(char: text))
			case .link(let url, let text):
				textNodes.append(LinkNode(url: url, text: text))
			}
		}

		return textNodes
	}
}
