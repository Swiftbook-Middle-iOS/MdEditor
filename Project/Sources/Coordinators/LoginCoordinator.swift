//
//  LoginCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit

protocol ILoginCoordinator: ICoordinator, IShowingError {
	func showLoginScene()
}

final class LoginCoordinator: ILoginCoordinator {
	// MARK: Public properties
	var childCoordinators: [ICoordinator] = []
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: Dependencies
	var navigationController: UINavigationController

	// MARK: Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: Public functions
	func start() {
		showLoginScene()
	}

	func showLoginScene() {
		let viewController = LoginAssembler().assembly { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success:
				self.finish()
			case .failure(let error):
				self.showError(message: error.localizedDescription)
			}
		}
		navigationController.setViewControllers([viewController], animated: true)
	}
}
