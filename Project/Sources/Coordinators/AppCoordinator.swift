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
	private var taskManager: ITaskManager
	private var fileExplorer: IFileExplorer

	init(
		window: UIWindow?,
		fileExplorer: IFileExplorer
	) {
		self.navigationController = UINavigationController()
		self.window = window
		self.fileExplorer = fileExplorer
		self.taskManager = OrderedTaskManager(taskManager: TaskManager())
	}

	// MARK: Public properties
	override func start() {
#if DEBUG
		if CommandLine.arguments.contains(CommandLineArguments.skipLogin.rawValue) {
			runTodoListFlow()

			window?.rootViewController = navigationController
			window?.makeKeyAndVisible()
			return
		} else if CommandLine.arguments.contains(CommandLineArguments.skipLoginForEditor.rawValue) {
			runEditorFlow()

			window?.rootViewController = navigationController
			window?.makeKeyAndVisible()
			return
		}
#endif
		runLoginFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self else { return }
			guard let coordinator = coordinator else { return }
			self.runEditorFlow()
			self.removeDependency(coordinator)
		}

		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	func runTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController, taskManager: taskManager)
		addDependency(coordinator)
#if DEBUG
		if CommandLine.arguments.contains(CommandLineArguments.enableTesting.rawValue) {
			coordinator.showTodoListSceneWithStubTasks()
		}
		return
#endif
		coordinator.start()
	}

	func runEditorFlow() {
		let coordinator = MainCoordinator(
			navigationController: navigationController
		)
		addDependency(coordinator)

		coordinator.start()
	}

	private func buildOrderedStubTaskManager() -> ITaskManager {
		let taskManager = TaskManager()
		let repository = TaskRepositoryStub()
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		return orderedTaskManager
	}
}
