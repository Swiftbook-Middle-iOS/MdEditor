//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit
import TaskManagerPackage

protocol IAppCoordinator: ICoordinator {
	func startLoginFlow()
	func startTodoListFlow()
}

final class AppCoordinator: IAppCoordinator {
	// MARK: Public properties
	var childCoordinators: [ICoordinator] = []
	var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: Dependencies
	var navigationController: UINavigationController
	private let taskManager: ITaskManager

	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: Public properties
	func start() {
		startLoginFlow()
	}

	func startLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		coordinator.finishDelegate = self
		childCoordinators.append(coordinator)
		coordinator.start()
	}

	func startTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController, taskManager: taskManager)
		coordinator.finishDelegate = self
		childCoordinators.append(coordinator)
		coordinator.start()
	}
}

// MARK: ICoordinatorFinishDelegate

extension AppCoordinator: ICoordinatorFinishDelegate {
	func didFinish(_ coordinator: ICoordinator) {
		if coordinator is ILoginCoordinator {
			startTodoListFlow()
			childCoordinators.removeAll { $0 === coordinator }
		}
	}
}
