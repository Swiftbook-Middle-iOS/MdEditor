//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IRecentFileManager {
	func getRecentFiles() -> [RecentFile]
}

final class RecentFileManager: IRecentFileManager {
	func getRecentFiles() -> [RecentFile] {
		return []
	}
}

final class StubRecentFileManager: IRecentFileManager {
	func getRecentFiles() -> [RecentFile] {
		return [
			RecentFile(
				previewText: "# О приложении",
				url: URL(string: NSTemporaryDirectory()),
				createDate: Date()
			),

			RecentFile(
				previewText: "# Как работать в Markdown с Заголовками",
				url: URL(string: NSTemporaryDirectory()),
				createDate: Date()
			),

			RecentFile(
				previewText: "# Вставка кода (code)",
				url: URL(string: NSTemporaryDirectory()),
				createDate: Date()
			),

			RecentFile(
				previewText: "# Экранирование (escaping characters)",
				url: URL(string: NSTemporaryDirectory()),
				createDate: Date()
			)
		]
	}
}
