//
//  FileBrowserPresenter.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IFileBrowserPresenter {
	func present(response: FileBrowserModel.Response)
}

final class FileBrowserPresenter: IFileBrowserPresenter {

	// MARK: Dependencies
	private weak var viewController: IFileBrowserViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: initialization
	init(viewController: IFileBrowserViewController) {
		self.viewController = viewController
	}

	// MARK: Public methods
	func present(response: FileBrowserModel.Response) {
		let components = response.currentPath.components(separatedBy: "/")
		var title = L10n.FileBrowser.title
		if let lastComponent = components.last {
			title = lastComponent
		}

		let viewModel = FileBrowserModel.ViewModel(items: mapFilesData(files: response.files), title: title)
		viewController.render(viewModel: viewModel)
	}

	// MARK: Private methods
	private func mapFilesData(files: [File]) -> [FileBrowserModel.ViewModel.ItemModel] {
		files.map { mapFileData(file: $0) }
	}

	private func mapFileData(file: File) -> FileBrowserModel.ViewModel.ItemModel {
		switch file.type {
		case .file:
			return .file(
				FileBrowserModel.ViewModel.FileModel(
					title: file.name,
					attributes: file.description
				)
			)
		case .dir:
			return .dir(
				FileBrowserModel.ViewModel.DirModel(
					title: "dir \(file.name)",
					attributes: file.description
				)
			)
		}
	}
}
