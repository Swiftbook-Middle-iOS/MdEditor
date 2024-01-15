//
//  MainCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit

/// Протокол для всех координаторов
protocol ICoordinator: AnyObject {
	var navigationController: UINavigationController { get set }
	var childCoordinators: [ICoordinator] { get set }
	var finishDelegate: ICoordinatorFinishDelegate? { get set }

	func start()
	func finish()
}

extension ICoordinator {
	/// Метод для вызова при завершении flow
	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(self)
	}
}

protocol ICoordinatorFinishDelegate: AnyObject {
	func didFinish(_ coordinator: ICoordinator)
}
