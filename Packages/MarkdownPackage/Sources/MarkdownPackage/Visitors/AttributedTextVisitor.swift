//
//  File.swift
//  
//
//  Created by Александр Мамлыго on /252/2567 BE.
//

import UIKit

final public class AttributedTextVisitor: IVisitor {

	private var orderedListCounters: [Int] = []
	private var unorderedListCounters: [Int] = []

	public init() {}

	public func visit(node: Document) -> [NSMutableAttributedString] {
		visitChildren(of: node)
	}

	public func visit(node: HeaderNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: "#", count: node.level) + " ")
		let text = visitChildren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.linebreak)
		result.append(String.linebreak)

		result.addAttribute(.font, value: UIFont.systemFont(ofSize: MarkdownTheme.getHeaderFontSize(for: node.level)), range: NSRange(0..<result.length))

		return result
	}

	public func visit(node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()
		result.append(String.linebreak)
		result.append(String.linebreak)
		return result
	}

	public func visit(node: BlockquoteNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: ">", count: node.level) + " ")
		let text = visitChildren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.linebreak)
		result.append(String.linebreak)

		return result
	}

	public func visit(node: TextNode) -> NSMutableAttributedString {
		let attributes: [NSMutableAttributedString.Key: Any] = [
			.foregroundColor: MarkdownTheme.Colors.textColor,
			.font: UIFont.systemFont(ofSize: MarkdownTheme.TextSize.normal.rawValue)
		]

		let result = NSMutableAttributedString(string: node.text, attributes: attributes)
		return result
	}

	public func visit(node: BoldTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("**")

		let attributes: [NSMutableAttributedString.Key: Any] = [
			.foregroundColor: MarkdownTheme.Colors.highlightedText,
			.font: UIFont.boldSystemFont(ofSize: MarkdownTheme.TextSize.normal.rawValue)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		return result
	}

	public func visit(node: ItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("*")

		let attributes: [NSMutableAttributedString.Key: Any] = [
			.foregroundColor: MarkdownTheme.Colors.highlightedText,
			.font: UIFont.italicSystemFont(ofSize: MarkdownTheme.TextSize.normal.rawValue)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		return result
	}

	public func visit(node: BoldItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("***")

		let font: UIFont

		if let fontDescriptor = UIFontDescriptor
			.preferredFontDescriptor(withTextStyle: .body)
			.withSymbolicTraits([.traitItalic, .traitBold]) {
			font = UIFont(descriptor: fontDescriptor, size: MarkdownTheme.TextSize.normal.rawValue)
		} else {
			font = UIFont.boldSystemFont(ofSize: MarkdownTheme.TextSize.normal.rawValue)
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

	public func visit(node: ImageNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()

		return result
	}

	public func visit(node: EscapedCharNode) -> NSMutableAttributedString {
		NSMutableAttributedString(string: node.char)
	}

	public func visit(node: InlineCodeNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		let attributes: [NSAttributedString.Key: Any] = [
				.font: UIFont.systemFont(ofSize: MarkdownTheme.TextSize.code.rawValue),
				.foregroundColor: MarkdownTheme.Colors.codeText,
				.backgroundColor: MarkdownTheme.Colors.codeBackground,
		]

		let code = NSMutableAttributedString(string: node.code, attributes: attributes)
		result.append(code)

		return result
	}

	public func visit(node: LinebreakNode) -> NSMutableAttributedString {
		return String.linebreak
	}

	public func visit(node: CodeblockNode) -> NSMutableAttributedString {
		visitChildren(of: node).joined()
	}

	public func visit(node: CodelineNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		let attributes: [NSAttributedString.Key: Any] = [
				.font: UIFont.systemFont(ofSize: MarkdownTheme.TextSize.code.rawValue),
				.foregroundColor: MarkdownTheme.Colors.codeText,
				.backgroundColor: MarkdownTheme.Colors.codeBackground,
		]

		let code = NSMutableAttributedString(string: node.code, attributes: attributes)
		result.append(code)
		result.append(String.linebreak)

		return result
	}

	public func visit(node: TaskNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(node.isDone ? String("[X] ") : String("[ ] "))
		let task = visitChildren(of: node).joined()
		if node.isDone {
			task.addAttribute(
				NSAttributedString.Key.strikethroughStyle,
				value: NSUnderlineStyle.single.rawValue,
				range: NSRange(location: 0, length: task.length)
			)
		}
		code.append(task)
		code.append(String.linebreak)
		return code
	}

	public func visit(node: OrderedListNode) -> NSMutableAttributedString {
		orderedListCounters.append(0)
		let result = visitChildren(of: node).joined()
		orderedListCounters.removeLast()

		return result
	}

	public func visit(node: OrderedListItemNode) -> NSMutableAttributedString {
		// Определение текущего индекса
		if let lastIndex = orderedListCounters.indices.last {
			orderedListCounters[lastIndex] += 1
		}

		let number = orderedListCounters.last ?? 1
		let listItemPrefix = "\t \(number)."

		// Отступ слева
		let paragraphStyle = NSMutableParagraphStyle()
		let tabStop = NSTextTab(textAlignment: .left, location: CGFloat(MarkdownTheme.listIndent * (orderedListCounters.count - 1)))
		paragraphStyle.tabStops = []
		paragraphStyle.addTabStop(tabStop)

		// Сбор контента в NSMutableAttributedString
		let content = visitChildren(of: node).joined()
		let fullText = NSMutableAttributedString(string: listItemPrefix)
		fullText.addAttributes(
			[
			.foregroundColor: MarkdownTheme.Colors.textColor,
			 .font: UIFont.systemFont(ofSize: MarkdownTheme.TextSize.code.rawValue)
			],
			range: NSRange(0..<fullText.length)
		)
		fullText.append(content)
		fullText.append(String.linebreak)
		fullText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.length))

		return fullText
	}

	public func visit(node: UnorderedListNode) -> NSMutableAttributedString {
		unorderedListCounters.append(0)
		let result = visitChildren(of: node).joined()
		unorderedListCounters.removeLast()

		return result
	}

	public func visit(node: UnorderedListItemNode) -> NSMutableAttributedString {
		// Отступ слева
		let paragraphStyle = NSMutableParagraphStyle()
		let tabStop = NSTextTab(textAlignment: .left, location: CGFloat(MarkdownTheme.listIndent * (unorderedListCounters.count - 1)))
		paragraphStyle.tabStops = []
		paragraphStyle.addTabStop(tabStop)

		// Сбор контента в NSMutableAttributedString
		let fullText = NSMutableAttributedString(string: "\t")
		let prefix = makeMarkdownCode("– ")
		let content = visitChildren(of: node).joined()
		fullText.append(prefix)
		fullText.append(content)
		fullText.append(String.linebreak)
		fullText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.length))

		return fullText
	}

	public func visit(node: LinkNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString(string: node.text)
		do {
			try result.setAsLink(textToFind: node.text, linkURL: node.url)
		} catch {
			result.append(NSMutableAttributedString(string: "[Invalid link]"))
		}

		let attributes: [NSMutableAttributedString.Key: Any] = [
			.font: UIFont.boldSystemFont(ofSize: MarkdownTheme.TextSize.normal.rawValue)
		]
		result.addAttributes(attributes, range: NSRange(location: 0, length: result.length))
		return result
	}

	public func visit(node: LineNode) -> NSMutableAttributedString {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: MarkdownTheme.lineWidth, height: MarkdownTheme.lineHeight))
		let image = renderer.image { ctx in
			ctx.cgContext.setFillColor(MarkdownTheme.Colors.lineColor)
			ctx.cgContext.fill(CGRect(x: 0, y: 0, width: MarkdownTheme.lineWidth, height: MarkdownTheme.lineHeight))
		}

		let attachment = NSTextAttachment()
		attachment.image = image
		let attachmentString = NSMutableAttributedString(attachment: attachment)
		attachmentString.append(NSAttributedString(string: "\n"))

		return attachmentString
	}
}

extension AttributedTextVisitor {
	func makeMarkdownCode(_ code: String) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.lightGray
		]

		return NSMutableAttributedString(string: code, attributes: attributes)
	}
}
