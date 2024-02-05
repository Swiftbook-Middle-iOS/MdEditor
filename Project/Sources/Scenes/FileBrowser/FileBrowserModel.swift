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
		let files: [FileModel]

		struct FileModel {
			let title: String
		}
	}

	struct Response {
		let files: [File]
	}
}
