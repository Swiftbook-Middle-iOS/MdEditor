//
//  LoginCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit

protocol ILoginCoordinator: ICoordinator {
    var finishFlow: (() -> Void)? { get set }
}

final class LoginCoordinator: ILoginCoordinator {

	// MARK: Dependencies
	var navigationController: UINavigationController
    var finishFlow: (() -> Void)?

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
                self.finishFlow?()
			case .failure(let error):
                self.showError(message: error.localizedDescription)
			}
		}
		navigationController.setViewControllers([viewController], animated: true)
	}

    // MARK: Private functions
    private func showError(message: String) {
        let alert: UIAlertController
        alert = UIAlertController(
            title: L10n.Error.text,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let action = UIAlertAction(title: L10n.Ok.text, style: .default)
        alert.addAction(action)
        navigationController.present(alert, animated: true, completion: nil)
    }
}
