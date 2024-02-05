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

	init(window: UIWindow?, taskManager: ITaskManager) {
		self.navigationController = UINavigationController()
		self.window = window
		self.taskManager = taskManager
	}

	// MARK: Public properties
	override func start() {
#if DEBUG
		if CommandLine.arguments.contains(CommandLineArguments.skipLogin.rawValue) {
			runTodoListFlow()

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

		coordinator.finishFlow = { [weak self] in
			guard let self = self else { return }
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

		coordinator.start()
	}

	func runEditorFlow() {
		let coordinator = EditorCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.start()
	}
}
