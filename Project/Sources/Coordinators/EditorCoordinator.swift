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
		let viewController = EditorHomeViewController()
		navigationController.setViewControllers([viewController], animated: true)
	}
}
