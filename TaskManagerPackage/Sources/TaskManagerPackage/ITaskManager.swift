//
//  ITaskManager.swift

/// Протокол для TaskManager
public protocol ITaskManager {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTask(task: Task)
	func addTasks(tasks: [Task])
}

extension TaskManager: ITaskManager { }

extension ImportantTask.TaskPriority: CustomStringConvertible {
	public var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
