//
//  String+Attributed.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

extension String {
	var attributed: NSMutableAttributedString {
		NSMutableAttributedString(string: self)
	}

	static var linebreak: NSMutableAttributedString {
		NSMutableAttributedString(string: "\n")
	}

	static var tab: NSMutableAttributedString {
		NSMutableAttributedString(string: "\t")
	}
}
