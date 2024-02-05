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
	private var fileExplorer: IFileExplorer
	private var presenter: IFileBrowserPresenter

	init(fileExplorer: IFileExplorer, presenter: IFileBrowserPresenter) {
		self.fileExplorer = fileExplorer
		self.presenter = presenter
	}

	func fetchData() {
		fileExplorer.scan(path: L10n.FileBrowser.filePath)
		presenter.present(response: FileBrowserModel.Response(files: fileExplorer.files))
	}
}
