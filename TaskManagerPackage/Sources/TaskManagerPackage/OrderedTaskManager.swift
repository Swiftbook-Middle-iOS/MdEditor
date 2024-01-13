//
//  OrderedTaskManager.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

/// Предоставляет список заданий, отсортированных по приоритету.
final public class OrderedTaskManager: ITaskManager {
	private let taskManager: ITaskManager

	public init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	public func addTask(task: Task) {
		taskManager.addTask(task: task)
	}

	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}
}

// Приватный extension с методом сортировки
private extension OrderedTaskManager {
	func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
			return false
		}
	}
}
