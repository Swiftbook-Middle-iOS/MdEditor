//
//  TaskRepository.swift
//  TodoList
//
//  Created by Kirill Leonov on 28.11.2023.
//

import Foundation
import TaskManagerPackage

/// Репозиторий для получения заданий.
protocol ITaskRepository {

	/// Получить список заданий.
	/// - Returns: Массив заданий.
	func getTasks() -> [Task]
}

/// Stub Репозиторя для получения заданий.
final class TaskRepositoryStub: ITaskRepository {

	/// Возвращает предустановленные данные для приолжения.
	/// - Returns: Массив заданий.
	func getTasks() -> [Task] {
		[
            ImportantTask(title: L10n.StubTasks.title0, taskPriority: .high),
            RegularTask(title: L10n.StubTasks.title1, completed: true),
            ImportantTask(title: L10n.StubTasks.title2, taskPriority: .low),
            RegularTask(title: L10n.StubTasks.title3),
            ImportantTask(title: L10n.StubTasks.title4, taskPriority: .medium)
		]
	}
}
