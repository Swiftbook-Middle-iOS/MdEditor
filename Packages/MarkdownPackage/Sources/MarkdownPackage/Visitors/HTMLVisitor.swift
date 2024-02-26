//
//  File.swift
//  
//
//  Created by Александр Мамлыго on /252/2567 BE.
//

import Foundation

final class HTMLVisitor: IVisitor {

	func visit(node: Document) -> [String] {
		visitChidren(of: node)
	}

	func visit(node: HeaderNode) -> String {
		let text = visitChidren(of: node).joined()
		return "<h\(node.level)>\(text)</h\(node.level)>"
	}

	func visit(node: ParagraphNode) -> String {
		let text = visitChidren(of: node).joined()
		return "<p>\(text)</p>"
	}

	func visit(node: BlockquoteNode) -> String {
		let text = visitChidren(of: node).joined()
		return "<blockquote><p>\(text)</p></blockquote>"
	}

	func visit(node: TextNode) -> String {
		node.text
	}

	func visit(node: BoldTextNode) -> String {
		"<strong>\(node.text)</stong>"
	}

	func visit(node: ItalicTextNode) -> String {
		"<em>\(node.text)</em>"
	}

	func visit(node: BoldItalicTextNode) -> String {
		"<strong><em>\(node.text)</em></strong>"
	}

	func visit(node: ImageNode) -> String {
		"<img src=\"\(node.url)>\" />"
	}

	func visit(node: EscapedCharNode) -> String {
		node.char
	}

	func visit(node: InlineCodeNode) -> String {
		"<code>\(node.code)</code>"
	}

	func visit(node: LinebreakNode) -> String {
		"<br/>"
	}

	func visit(node: TaskNode) -> String {
		let text = visitChidren(of: node).joined()
		return "<p>\(text)</p>"
	}
}
