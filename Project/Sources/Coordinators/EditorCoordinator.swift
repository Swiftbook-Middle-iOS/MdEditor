//
//  EditorCoordinator.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

protocol IEditorCoordinator: ICoordinator {
}

class EditorCoordinator: IEditorCoordinator {
	// MARK: Dependencies
	var navigationController: UINavigationController
	var fileExplorer: IFileExplorer

	// MARK: Initialization
	init(navigationController: UINavigationController, fileExplorer: IFileExplorer) {
		self.navigationController = navigationController
		self.fileExplorer = fileExplorer
	}

	// MARK: Public functions
	func start() {
		let openFileClosure: () -> Void = { [weak self] in
			self?.openBrowserScreen(at: L10n.FileBrowser.filePath)
		}

		let aboutAppClosure: () -> Void = { [weak self] in
			self?.openAboutAppScreen()
		}

		let viewController = EditorHomeAssembly().assembly(openFileClosure: openFileClosure, aboutAppClosure: aboutAppClosure)
		navigationController.setViewControllers([viewController], animated: true)
	}

	private func openBrowserScreen(at filePath: String) {
		navigationController.pushViewController(
			FileBrowserAssembler().assembly(fileExplorer: fileExplorer, currentPath: filePath) { [weak self] newPath in
				self?.openBrowserScreen(at: newPath)
			},
			animated: true
		)
	}

	private func openAboutAppScreen() {
		navigationController.pushViewController(AboutAppViewController(), animated: true)
	}
}
