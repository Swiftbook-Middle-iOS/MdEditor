//
//  File.swift
//  
//
//  Created by Александр Мамлыго on /252/2567 BE.
//

import Foundation

public final class HTMLVisitor: IVisitor {
	public init() {}
	
	public func visit(node: Document) -> [String] {
		[makeHtml(visitChidren(of: node).joined())]
	}

	public func visit(node: HeaderNode) -> String {
		let text = visitChidren(of: node).joined()
		return "<h\(node.level)>\(text)</h\(node.level)>"
	}

	public func visit(node: ParagraphNode) -> String {
		let text = visitChidren(of: node).joined()
		return "<p>\(text)</p>"
	}

	public func visit(node: BlockquoteNode) -> String {
		let text = visitChidren(of: node).joined()
		return "<blockquote><p>\(text)</p></blockquote>"
	}

	public func visit(node: TextNode) -> String {
		node.text
	}

	public func visit(node: BoldTextNode) -> String {
		"<strong>\(node.text)</stong>"
	}

	public func visit(node: ItalicTextNode) -> String {
		"<em>\(node.text)</em>"
	}

	public func visit(node: BoldItalicTextNode) -> String {
		"<strong><em>\(node.text)</em></strong>"
	}

	public func visit(node: ImageNode) -> String {
		"<img src=\"\(node.url)>\" />"
	}

	public func visit(node: EscapedCharNode) -> String {
		node.char
	}

	public func visit(node: InlineCodeNode) -> String {
		"<code>\(node.code)</code>"
	}

	public func visit(node: LinebreakNode) -> String {
		"<br/>"
	}
}

private extension HTMLVisitor {
	func makeHtml(_ text: String) -> String {
		"<!DOCTYPE html><html><head><style> body {font-size: 350%;} </style></head><body>\(text)</body></html>"
	}
}
