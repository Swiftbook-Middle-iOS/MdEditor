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

	// MARK: Dependencies
	var navigationController: UINavigationController
	private let taskManager: ITaskManager = TaskManager()

	// MARK: Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: Public functions
	func start() {
		showTodoListScene()
	}

	func showTodoListScene() {
        let repository = TaskRepositoryStub()
        let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
        orderedTaskManager.addTasks(tasks: repository.getTasks())

        let viewController = TodoListAssembler(taskManager: orderedTaskManager).assembly()
		navigationController.setViewControllers([viewController], animated: true)
	}
}
