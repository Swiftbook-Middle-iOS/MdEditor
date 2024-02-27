//
//  File.swift
//  
//
//  Created by Aleksandr Mamlygo on 26.02.24.
//

import Foundation

public final class MarkdownToHtmlConverter {
	private let markdownToDocument = MarkdownToDocument()

	public init() {}

	public func convert(markdownText: String) -> String {
		let document = markdownToDocument.convert(markdownText: markdownText)
		print(document)

		let visitor = HTMLVisitor()
		let html = document.accept(visitor: visitor)

		return makeHtml(html.joined())
	}
}

private extension MarkdownToHtmlConverter {
	func makeHtml(_ text: String) -> String {
		"<!DOCTYPE html><html><head><style> body {font-size: 350%;} </style></head><body>\(text)</body></html>"
	}
}
