//
//  File.swift
//  
//
//  Created by Александр Мамлыго on /252/2567 BE.
//

import Foundation

extension Document: CustomStringConvertible {
	public var description: String {
		"\(children.map { "\($0)" }.joined(separator: "\n"))"
	}
}

extension HeaderNode: CustomStringConvertible {
	public var description: String {
		"Header Level\n\t \(level) \(children.map { "\($0)" }.joined(separator: " "))"
	}
}

extension ParagraphNode: CustomStringConvertible {
	public var description: String {
		"Paragraph\n\t \(children.map { "\($0)" }.joined(separator: " "))"
	}
}

extension TextNode: CustomStringConvertible {
	public var description: String {
		"Text node: \(text)"
	}
}

extension BoldTextNode: CustomStringConvertible {
	public var description: String {
		"Bold text node: \(text)"
	}
}

extension ItalicTextNode: CustomStringConvertible {
	public var description: String {
		"Italic text node: \(text)"
	}
}

extension BoldItalicTextNode: CustomStringConvertible {
	public var description: String {
		"Bold italic text node: \(text)"
	}
}

extension UnorderedListNode: CustomStringConvertible {
	public var description: String {
		"Unordered list level \(level) \n\t\t \(children.map { "\($0)" }.joined(separator: "\n\t\t"))"
	}
}

extension UnorderedListItemNode: CustomStringConvertible {
	public var description: String {
		"Unordered list item: \(children.map { "\($0)" }.joined(separator: ""))"
	}
}

extension OrderedListNode: CustomStringConvertible {
	public var description: String {
		"Ordered list level \(level) \n\t\t \(children.map { "\($0)" }.joined(separator: "\n\t\t"))"
	}
}

extension OrderedListItemNode: CustomStringConvertible {
	public var description: String {
		"Ordered list item: \(children.map { "\($0)" }.joined(separator: ""))"
	}
}

extension BlockquoteNode: CustomStringConvertible {
	public var description: String {
		"Blockquote level \(level): \(children.map { "\($0)" }.joined(separator: "\n"))"
	}
}

