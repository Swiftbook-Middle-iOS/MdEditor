//
//  Tokens.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 20.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

public enum Token {
	case header(level: Int, text: Text)
	case blockquote(level: Int, text: Text)
	case codeBlockMarker(level: Int, lang: String)
	case codeLine(text: String)
	case unorderedListItem(level: Int, text: Text)
	case orderedListItem(level: Int, text: Text)
	case textLine(text: Text)
	case link(url: String, text: String)
	case image(url: String, size: Int)
	case lineBreak
}

public struct Text {
	let text: [Part]

	enum Part {
		case normal(text: String)
		case bold(text: String)
		case italic(text: String)
		case boldItalic(text: String)
		case inlineCode(text: String)
		case escapedChar(text: String)
	}
}
