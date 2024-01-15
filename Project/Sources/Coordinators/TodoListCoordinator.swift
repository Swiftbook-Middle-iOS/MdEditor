//
//  TodoListCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit
import TaskManagerPackage

protocol ITodoListCoordinator: ICoordinator {
	func showTodoListScene()
}

final class TodoListCoordinator: ITodoListCoordinator {
	// MARK: Public properties
	var childCoordinators: [ICoordinator] = []
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: Dependencies
	var navigationController: UINavigationController
	private let taskManager: ITaskManager

	// MARK: Initialization
	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: Public functions
	func start() {
		showTodoListScene()
	}

	func showTodoListScene() {
        let viewController = TodoListAssembler(taskManager: taskManager).assembly()
		navigationController.setViewControllers([viewController], animated: true)
	}
}
