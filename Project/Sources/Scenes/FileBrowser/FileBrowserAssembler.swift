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
		currentPath: URL,
		newDirClosure: @escaping (URL) -> Void,
		errorClosure: (() -> Void)? = nil
	) -> FileBrowserViewController {
		let viewController = FileBrowserViewController()
		let presenter = FileBrowserPresenter(viewController: viewController)
		let interactor = FileBrowserInteractor(
			fileExplorer: fileExplorer,
			currentPath: currentPath,
			presenter: presenter,
			newDirClosure: newDirClosure,
			errorClosure: errorClosure
		)

		viewController.interactor = interactor

		return viewController
	}

	/// Метод для сброки сцены FileBrowser в случае сборки корневого экрана вручную из файлов/папок,
	/// лежащих в разных директориях
	func rootAssembly(newDirClosure: @escaping (URL) -> Void) -> FileBrowserViewController {
		let viewController = FileBrowserViewController()
		let presenter = FileBrowserPresenter(viewController: viewController)
		let interactor = FileBrowserRootInteractor(presenter: presenter, newDirClosure: newDirClosure)
		viewController.interactor = interactor

		return viewController
	}
}
