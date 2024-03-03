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

	static let lineWidth = UIScreen.main.bounds.width
	static let lineHeight: CGFloat = 2
	static let lineColor = UIColor(red: 0.7, green: 0.4, blue: 0.8, alpha: 1.0).cgColor


	enum TextSize: CGFloat {
		case normal = 18
		case code = 16
	}

	static func getHeaderFontSize(for level: Int) -> CGFloat {
		guard level > 0, level <= headerSizes.count else { return UIFont.systemFontSize }
		return headerSizes[level - 1]
	}
}
