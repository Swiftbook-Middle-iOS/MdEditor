//
//  FileBrowserModel.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

enum FileBrowserModel {
	struct ViewModel {
		let items: [ItemModel]
		let title: String

		enum ItemModel {
			case file(FileModel)
			case dir(DirModel)
		}

		struct FileModel {
			let title: String
			let attributes: String
		}

		struct DirModel {
			let title: String
			let attributes: String
		}
	}

	struct Response {
		let files: [File]
		let currentPath: String
	}
}
