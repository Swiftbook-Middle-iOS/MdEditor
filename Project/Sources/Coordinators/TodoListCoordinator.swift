//
//  TodoListCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit
import TaskManagerPackage
import MarkdownPackage

protocol ITodoListCoordinator: ICoordinator {
	func showTodoListScene()
}

final class TodoListCoordinator: ITodoListCoordinator {

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
		if case .success(let file) = File.parse(url: Endpoints.testMd) {
			let markdownText = String(data: file.contentOfFile() ?? Data(), encoding: .utf8) ?? ""
			let document = MarkdownToDocument().convert(markdownText: markdownText)
			let taskRepository = TaskScanner(document: document)

			taskManager.addTasks(tasks: taskRepository.getTasks())
			let viewController = TodoListAssembler(taskManager: taskManager).assembly()
			navigationController.setViewControllers([viewController], animated: true)
		}
	}
}
