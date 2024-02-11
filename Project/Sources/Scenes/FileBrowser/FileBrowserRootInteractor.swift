//
//  FileBrowserRootInteractor.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /82/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

/// Имплементация IFileBrowserInteractor для корневого экрана.
/// Необходима в случае, если нужно собрать корневой экран с папками/документами из разных директорий,
/// например, из Resources + папки Documents приложения
final class FileBrowserRootInteractor: IFileBrowserInteractor {

	// MARK: Private properties
	private lazy var rootItems = [makeFileForAssetsFolder(), makeFileForDocumentsFolder()]

	// MARK: Dependencies
	private var presenter: IFileBrowserPresenter
	private var newDirClosure: (URL) -> Void

	// MARK: Initialization
	init(presenter: IFileBrowserPresenter, newDirClosure: @escaping (URL) -> Void) {
		self.presenter = presenter
		self.newDirClosure = newDirClosure
	}

	// MARK: IFileBrowserInteractor
	func fetchData() {
		presenter.present(response: FileBrowserModel.Response(
			files: rootItems,
			currentPath: URL(fileURLWithPath: "")
		))
	}

	func didSelectItem(at index: Int) {
		let item = rootItems[index]
		guard let fullPath = item.fullPath else { return }
		if item.type == .dir {
			newDirClosure(fullPath)
		}
	}

	// MARK: Private methods
	private func makeFileForAssetsFolder() -> File {
		guard let assetsFolderUrl = Bundle.main.resourceURL?.appendingPathComponent(L10n.FileBrowser.baseAssetsPath) else {
			return File()
		}

		let assetsFolder = File()
		assetsFolder.name = "Assets"
		assetsFolder.path = assetsFolderUrl.deletingLastPathComponent()
		assetsFolder.fullPath = assetsFolderUrl
		assetsFolder.type = .dir

		return assetsFolder
	}

	private func makeFileForDocumentsFolder() -> File {
		guard let documentsURL = try? FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		) else { return File() }

		let documentsFolder = File()
		documentsFolder.name = "Documents"
		documentsFolder.path = documentsURL.deletingLastPathComponent()
		documentsFolder.fullPath = documentsURL
		documentsFolder.type = .dir

		return documentsFolder
	}
}
