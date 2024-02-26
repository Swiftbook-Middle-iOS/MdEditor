//
//  File.swift
//  
//
//  Created by Aleksandr Mamlygo on 26.02.24.
//

import Foundation
import PDFKit

public final class MarkdownToPdfConverter {
	private let lexer = Lexer()
	private let parser = Parser()

	public init() {}

	public func convert(markdownText: String, pdfAuthor: String, pdfTitle: String) -> Data {
		let tokens = lexer.tokenize(markdownText)
		let document = parser.parse(tokens: tokens)

		let visitor = AttributedTextVisitor()
		let lines = document.accept(visitor: visitor)

		let pdfMetaData = [
			kCGPDFContextAuthor as String: pdfAuthor,
			kCGPDFContextTitle as String: pdfTitle
		]

		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData

		let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
		let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

		let data = graphicsRenderer.pdfData { context in
			context.beginPage()

			var cursor: CGFloat = Const.initialCursorPosition

			lines.forEach { line in
				cursor = addAttributedText(
					context: context,
					text: line,
					indent: Const.indent,
					cursor: cursor,
					pdfSize: pageRect.size
				)
				cursor += Const.lineSpacing
			}
		}

		return data
	}
}

private extension MarkdownToPdfConverter {

	func addAttributedText(context: UIGraphicsPDFRendererContext, text: NSAttributedString, indent: CGFloat, cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
		let pageSize = CGSize(
			width: pdfSize.width - 2 * indent,
			height: pdfSize.height - 2 * indent
		)

		let textHeight = textHeight(text, pdfSize: pageSize)
		let rect = CGRect(x: indent, y: cursor, width: pageSize.width, height: textHeight)
		text.draw(in: rect)

		return checkContext(context: context, cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
	}

	func textHeight(_ text: NSAttributedString, pdfSize: CGSize) -> CGFloat {
		let rect = CGSize(width: pdfSize.width, height: .greatestFiniteMagnitude)
		let boundingRect = text.boundingRect(with: rect, options: .usesLineFragmentOrigin, context: nil)

		return ceil(boundingRect.height)
	}

	func checkContext(context: UIGraphicsPDFRendererContext, cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
		if cursor > pdfSize.height - 100 {
			context.beginPage()
			return Const.initialCursorPosition
		}

		return cursor
	}

	enum Const {
		static let initialCursorPosition: CGFloat = 0
		static let lineSpacing: CGFloat = 0
		static let indent: CGFloat = 24
	}
}
