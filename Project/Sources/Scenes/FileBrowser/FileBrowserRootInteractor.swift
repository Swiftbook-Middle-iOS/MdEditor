//
//  FileBrowserRootInteractor.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /82/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class FileBrowserRootInteractor: IFileBrowserInteractor {

	private lazy var rootDirs = [makeFileForAssetsFolder()]
	private var presenter: IFileBrowserPresenter
	private var newDirClosure: (URL) -> Void

	init(presenter: IFileBrowserPresenter, newDirClosure: @escaping (URL) -> Void) {
		self.presenter = presenter
		self.newDirClosure = newDirClosure
	}

	func fetchData() {
		presenter.present(response: FileBrowserModel.Response(
			files: rootDirs,
			currentPath: URL(fileURLWithPath: "")
		))
	}

	func didSelectItem(at index: Int) {
		let item = rootDirs[index]
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
}
