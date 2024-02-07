//
//  FileBrowserRootInteractor.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /82/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class FileBrowserRootInteractor: IFileBrowserInteractor {

	private lazy var rootItems = [makeFileForAssetsFolder(), makeFileForDocumentsFolder()]
	private var presenter: IFileBrowserPresenter
	private var newDirClosure: (URL) -> Void

	init(presenter: IFileBrowserPresenter, newDirClosure: @escaping (URL) -> Void) {
		self.presenter = presenter
		self.newDirClosure = newDirClosure
	}

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
		guard let documentsURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return File() }

		let documentsFolder = File()
		documentsFolder.name = "Documents"
		documentsFolder.path = documentsURL.deletingLastPathComponent()
		documentsFolder.fullPath = documentsURL
		documentsFolder.type = .dir

		return documentsFolder
	}
}
