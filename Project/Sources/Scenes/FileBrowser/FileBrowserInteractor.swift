//
//  FileBrowserInteractor.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IFileBrowserInteractor {
	func fetchData()
}

final class FileBrowserInteractor: IFileBrowserInteractor {
	var fileExplorer: IFileExplorer

	init(fileExplorer: IFileExplorer) {
		self.fileExplorer = fileExplorer
	}

	func fetchData() {
		fileExplorer.scan(path: "")
	}
}
