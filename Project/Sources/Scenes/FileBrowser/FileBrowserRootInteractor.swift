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
			files: rootItems.compactMap { $0 },
			currentPath: URL(fileURLWithPath: "")
		))
	}

	func didSelectItem(at index: Int) {
		let item = rootItems[index]
		guard let item = item else { return }
		if item.isFolder {
			newDirClosure(item.url)
		}
	}

	// MARK: Private methods
	private func makeFileForAssetsFolder() -> File? {
		guard let assetsFolderUrl = Bundle.main.resourceURL?.appendingPathComponent(Endpoints.baseAssetsPath.rawValue) else {
			return nil
		}
		switch File.parse(url: assetsFolderUrl) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}

	private func makeFileForDocumentsFolder() -> File? {
		guard let documentsURL = try? FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		) else {
			return nil
		}

		switch File.parse(url: documentsURL) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}
}
