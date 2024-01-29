//
//  MainCoordinator.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit

/// Протокол для всех координаторов
protocol ICoordinator: AnyObject {
	func start()
}

class BaseCoordinator: ICoordinator {

    var childCoordinators: [ICoordinator] = []

    func start() {}

    /// Добавление зависимости (coordinator) в массив childCoordinators.
    ///
    /// Добавление новой зависимости только в том случае, если такой зависимости еще нет в массиве childCoordinators.
    /// - Parameter coordinator: Зависимость, которую необходимо добавить.
    func addDependency(_ coordinator: ICoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    /// Удаление зависимости (coordinator) из массива childCoordinators у родительского координатора.
    ///
    /// Код проверяет, является ли переданный координатор подтипом BaseCoordinator и имеет ли дочерние координаторы.
    /// Если условие выполняется, то происходит рекурсивный вызов removeDependency для каждого дочернего координатора,
    ///  чтобы удалить все их зависимости.
    /// - Parameter coordinator: Зависимость, которую необходимо удалить.
    func removeDependency(_ coordinator: ICoordinator) {
        guard !childCoordinators.isEmpty else { return }

        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.forEach { coordinator.removeDependency($0) }
        }

        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
