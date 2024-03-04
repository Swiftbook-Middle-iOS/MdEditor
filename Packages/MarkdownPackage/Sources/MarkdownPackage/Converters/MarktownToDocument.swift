//
//  File.swift
//  
//
//  Created by Aleksandr Mamlygo on 26.02.24.
//

import Foundation

public final class MarkdownToDocument {
	private var lexer = Lexer()
	private var parser = Parser()

	public init() {}

	public func convert(markdownText: String) -> Document {
		let tokens = lexer.tokenize(markdownText)
		let document = parser.parse(tokens: tokens)

		return document
	}
}
