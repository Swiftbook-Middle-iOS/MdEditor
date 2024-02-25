//
//  EditorHomeModel.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

enum EditorHomeModel {
	enum Request {
		enum MenuItemSelected {
			case newFile
			case openFile
			case aboutApp
		}
	}

	struct Response {
		let recentFiles: [RecentFile]
	}

	struct ViewModel {
		let recentFiles: [RecentFile]

		struct RecentFile {
			let previewText: String
			let fileName: String
		}
	}
}
