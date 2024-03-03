//
//  File.swift
//  
//
//  Created by Aleksandr Mamlygo on 03.03.24.
//

import Foundation

enum AttributedStringError: Error {
	case textNotFound
}

extension NSMutableAttributedString {
	func setAsLink(textToFind:String, linkURL:String) throws {
		let foundRange = self.mutableString.range(of: textToFind)
		if foundRange.location != NSNotFound {
			self.addAttribute(.link, value: linkURL, range: foundRange)
		} else {
			throw AttributedStringError.textNotFound
		}
	}
}
