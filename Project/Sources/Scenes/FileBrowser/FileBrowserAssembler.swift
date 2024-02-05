//
//  FileBrowserAssembler.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class FileBrowserAssembler {
	func assembly(fileExplorer: IFileExplorer) -> FileBrowserViewController {
		let viewController = FileBrowserViewController()
		let presenter = FileBrowserPresenter(viewController: viewController)
		let interactor = FileBrowserInteractor(fileExplorer: fileExplorer, presenter: presenter)

		viewController.interactor = interactor

		return viewController
	}
}
