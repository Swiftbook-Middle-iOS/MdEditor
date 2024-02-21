//
//  Nodes.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 20.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

public protocol INode {
	var children: [INode] { get }
}

public class BaseNode: INode {
	public private(set) var children: [INode]

	init(_ children: [INode] = []) {
		self.children = children
	}
}

public final class Document: BaseNode {
}

public final class HeaderNode: BaseNode {
	let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class BlockquoteNode: BaseNode {
	let level: Int

	public init(level: Int, _ children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

class ParagraphNode: BaseNode {
}

public final class TextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class ItalicTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldItalicTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class CodeblockNode: BaseNode {
	let level: Int
	let lang: String

	public init(level: Int, lang: String, children: [CodelineNode] = []) {
		self.level = level
		self.lang = lang
		super.init(children)
	}
}

public final class CodelineNode: BaseNode {
	let code: String

	public init(code: String) {
		self.code = code
	}
}

public final class InlineCodeNode: BaseNode {
	let code: String

	public init(code: String) {
		self.code = code
	}
}

public final class EscapedCharNode: BaseNode {
	let char: String

	public init(char: String) {
		self.char = char
	}
}

public final class ImageNode: BaseNode {
	let url: String
	let size: Int

	public init(url: String, size: Int) {
		self.url = url
		self.size = size
	}
}

public final class OrderedListNode: BaseNode {
	let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class OrderedListItemNode: BaseNode {
}

public final class UnorderedListNode: BaseNode {
	let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class UnorderedListItemNode: BaseNode {
}

public final class LinkNode: BaseNode {
	let url: String
	let text: String

	public init(url: String, text: String) {
		self.url = url
		self.text = text
	}
}

public final class LinebreakNode: BaseNode {
	public init() {}
}
