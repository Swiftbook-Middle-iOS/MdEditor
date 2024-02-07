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
	private var currentPath: URL
	private var presenter: IFileBrowserPresenter
	private var newDirClosure: (URL) -> Void
	private var errorClosure: (() -> Void)?

	// MARK: Initialization
	init(
		fileExplorer: IFileExplorer,
		currentPath: URL,
		presenter: IFileBrowserPresenter,
		newDirClosure: @escaping (URL) -> Void,
		errorClosure: (() -> Void)? = nil
	) {
		self.fileExplorer = fileExplorer
		self.currentPath = currentPath
		self.presenter = presenter
		self.newDirClosure = newDirClosure
		self.errorClosure = errorClosure
	}

	// MARK: Public methods
	func fetchData() {
		do {
			try fileExplorer.scan(path: currentPath)
		} catch {
			errorClosure?()
		}
		presenter.present(response: FileBrowserModel.Response(files: fileExplorer.files, currentPath: currentPath))
	}

	func didSelectItem(at index: Int) {
		let item = fileExplorer.files[index]
		if item.type == .dir {
			let newURL = currentPath.appendingPathComponent(item.name)
			newDirClosure(newURL)
		}
	}
}
