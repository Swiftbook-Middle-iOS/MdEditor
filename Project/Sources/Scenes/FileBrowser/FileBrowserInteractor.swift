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
	func didSelectItem(at index: Int)
}

final class FileBrowserInteractor: IFileBrowserInteractor {

	// MARK: Dependencies
	private var fileExplorer: IFileExplorer
	private var currentPath: String
	private var presenter: IFileBrowserPresenter
	private var newDirClosure: (String) -> Void

	// MARK: Initialization
	init(
		fileExplorer: IFileExplorer,
		currentPath: String,
		presenter: IFileBrowserPresenter,
		newDirClosure: @escaping (String) -> Void
	) {
		self.fileExplorer = fileExplorer
		self.currentPath = currentPath
		self.presenter = presenter
		self.newDirClosure = newDirClosure
	}

	// MARK: Public methods
	func fetchData() {
		fileExplorer.scan(path: currentPath)
		presenter.present(response: FileBrowserModel.Response(files: fileExplorer.files, currentPath: currentPath))
	}

	func didSelectItem(at index: Int) {
		let item = fileExplorer.files[index]
		if item.type == .dir {
			let newPath = currentPath + "/\(item.name)"
			newDirClosure(newPath)
		}
	}
}
