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

	// MARK: Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: Public functions
	func start() {
		let viewController = EditorHomeAssembly().assembly { [weak self] in
			self?.openBrowserScreen()
		}
		navigationController.setViewControllers([viewController], animated: true)
	}

	private func openBrowserScreen() {
		navigationController.pushViewController(FileBrowserViewController(), animated: true)
	}
}
