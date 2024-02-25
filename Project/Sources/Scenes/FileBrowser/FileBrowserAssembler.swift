//
//  FileBrowserAssembler.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class FileBrowserAssembler {
	/// Метод для сборки сцены FileBrowser в случае просмотра конкретной директории (URL)
	func assembly(
		fileExplorer: IFileExplorer,
		currentPath: URL?
	) -> (FileBrowserViewController, FileBrowserInteractor) {
		let viewController = FileBrowserViewController()
		let presenter = FileBrowserPresenter(viewController: viewController)
		let interactor = FileBrowserInteractor(
			fileExplorer: fileExplorer,
			currentPath: currentPath,
			presenter: presenter
		)

		viewController.interactor = interactor

		return (viewController, interactor)
	}
}
