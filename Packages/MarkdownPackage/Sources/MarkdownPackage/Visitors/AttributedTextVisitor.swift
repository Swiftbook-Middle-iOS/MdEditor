//
//  File.swift
//  
//
//  Created by Александр Мамлыго on /252/2567 BE.
//

import UIKit

final class AttributedTextVisitor: IVisitor {

	func visit(node: Document) -> [NSMutableAttributedString] {
		visitChidren(of: node)
	}

	func visit(node: HeaderNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: "#", count: node.level) + " ")
		let text = visitChidren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.linebreak)
		result.append(String.linebreak)

		let sizes: [CGFloat] = [32, 28, 26, 24, 22, 20]

		result.addAttribute(.font, value: UIFont.systemFont(ofSize: sizes[node.level - 1]), range: NSRange(0..<result.length))

		return result
	}

	func visit(node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChidren(of: node).joined()
		result.append(String.linebreak)
		result.append(String.linebreak)
		return result
	}

	func visit(node: BlockquoteNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: ">", count: node.level) + " ")
		let text = visitChidren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.linebreak)
		result.append(String.linebreak)

		return result
	}

	func visit(node: TextNode) -> NSMutableAttributedString {
		let attributes: [NSMutableAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.systemFont(ofSize: 18)
		]

		let result = NSMutableAttributedString(string: node.text, attributes: attributes)
		return result
	}

	func visit(node: BoldTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("**")

		let attributes: [NSMutableAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.font: UIFont.boldSystemFont(ofSize: 18)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		return result
	}

	func visit(node: ItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("*")

		let attributes: [NSMutableAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.font: UIFont.italicSystemFont(ofSize: 18)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		return result
	}

	func visit(node: BoldItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("***")

		let font: UIFont

		if let fontDescriptor = UIFontDescriptor
			.preferredFontDescriptor(withTextStyle: .body)
			.withSymbolicTraits([.traitItalic, .traitBold]) {
			font = UIFont(descriptor: fontDescriptor, size: 18)
		} else {
			font = UIFont.boldSystemFont(ofSize: 18)
		}

		let attributes: [NSMutableAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.font: font
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		return result
	}

	func visit(node: ImageNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()

		return result
	}

	func visit(node: EscapedCharNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()

		return result
	}

	func visit(node: InlineCodeNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()

		return result
	}

	func visit(node: LinebreakNode) -> NSMutableAttributedString {
		return String.linebreak
	}

	func visit(node: TaskNode) -> NSMutableAttributedString {
		return visitChidren(of: node).joined()
	}
}

private extension AttributedTextVisitor {
	func makeMarkdownCode(_ code: String) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.lightGray
		]

		return NSMutableAttributedString(string: code, attributes: attributes)
	}
}
