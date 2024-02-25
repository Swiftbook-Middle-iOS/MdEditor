//
//  Sequence + Joined.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

public extension Sequence where Iterator.Element == NSMutableAttributedString {
	func joined() -> NSMutableAttributedString {
		reduce(into: NSMutableAttributedString()) { $0.append($1) }
	}
}
