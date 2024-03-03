//
//  File.swift
//  
//
//  Created by Aleksandr Mamlygo on 26.02.24.
//

import Foundation

public protocol IAttributedConverter {
	func convertMdText(_ markdownText: String) -> [NSMutableAttributedString]
}

public final class AttributedCoverter: IAttributedConverter {
	private let markdownToDocument = MarkdownToDocument()
	private let visitor = AttributedTextVisitor()

	public init() {}

	public func convertMdText(_ markdownText: String) -> [NSMutableAttributedString] {
		let document = markdownToDocument.convert(markdownText: markdownText)
		let attributed = document.accept(visitor: visitor)

		return attributed
	}

	public func convertTaskNode(node: TaskNode) -> NSMutableAttributedString {
		let attributed = node.accept(visitor: visitor)

		return attributed
	}
}
