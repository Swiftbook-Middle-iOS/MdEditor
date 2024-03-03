//
//  File.swift
//  
//
//  Created by Aleksandr Mamlygo on 29.02.24.
//

import UIKit

struct MarkdownTheme {
	static let headerSizes: [CGFloat] = [32, 28, 26, 24, 22, 20]
	static let listIndent = 36

	enum TextSize: CGFloat {
		case normal = 18
		case code = 16
	}

	static func getHeaderFontSize(for level: Int) -> CGFloat {
		guard level > 0, level <= headerSizes.count else { return UIFont.systemFontSize }
		return headerSizes[level - 1]
	}
}
