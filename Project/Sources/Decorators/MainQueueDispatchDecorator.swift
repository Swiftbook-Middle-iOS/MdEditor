//
//  MainQueueDispatchDecorator.swift
//  MdEditor
//
//  Created by Александр Касьянов on 13.03.2024.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
import MarkdownPackage

final class MainQueueAttributedConverterDecorator: IAttributedConverter {

	let decoratee: IAttributedConverter

	init(decoratee: IAttributedConverter) {
		self.decoratee = decoratee
	}

	func doInMainThread(_ work: @escaping () -> Void) {
		if Thread.isMainThread {
			work()
		} else {
			DispatchQueue.main.async(execute: work)
		}
	}

	func convertMdText(_ markdownText: String) -> [NSMutableAttributedString] {
		var attributed: [NSMutableAttributedString] = []
		doInMainThread { [weak self] in
			guard let self = self else { return }
			attributed = self.decoratee.convertMdText(markdownText)
		}
		return attributed
	}
}
