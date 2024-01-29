//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: Dependencies
	private var navigationController: UINavigationController
    private var window: UIWindow?

    init(window: UIWindow?) {
		self.navigationController = UINavigationController()
		self.window = window
	}

	// MARK: Public properties
	override func start() {
		runLoginFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
        addDependency(coordinator)

        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
			self.startTodoListFlow()
			self.removeDependency(coordinator)
        }

		coordinator.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
	}

	func startTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController)
        addDependency(coordinator)

		coordinator.start()
	}
}
