//
//  Tokens.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 20.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

enum Token {
	case header(level: Int, text: Text)
	case blockquote(level: Int, text: Text)
	case paragraph(text: Text)
	case link(url: String, text: String)
	case image(urk: String, size: Int)
	case lineBreak
}

struct Text {
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
