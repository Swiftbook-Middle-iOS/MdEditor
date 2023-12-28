import XCTest
@testable import TaskManagerPackage

final class TaskManagerPackageTests: XCTestCase {
	let sut = TaskManager()

	let task = Task(title: "Test task")

	var tasks: [Task] {
		[task, task]
	}

	var completedTasks: [Task] {
		[
			Task(title: "Test task", completed: true),
			Task(title: "Test task", completed: true)
		]
	}

	var uncompletedTasks: [Task] {
		[
			Task(title: "Test task", completed: false),
			Task(title: "Test task", completed: false)
		]
	}

	var isEmpty: Bool {
		sut.allTasks().isEmpty
	}

	var count: Int {
		sut.allTasks().count
	}

	func test_addOneTask_shouldBeSuccess() {
		sut.addTask(task: task)

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия задания должен быть - False")
	}

	func test_addOneTasks_shouldBeSuccess() {
		sut.addTasks(tasks: tasks)

		let result = count > 1

		XCTAssertTrue(result, "Результат проверки добавления задания должен быть - True")
	}

	func test_getAllTasks_shouldBeSuccess() {
		sut.addTasks(tasks: tasks)

		let result = tasks.count == sut.allTasks().count

		XCTAssertTrue(result, "Результат проверки получения всех заданий должен быть - True")
	}

	func test_removeTask_shouldBeSuccess() {
		sut.addTask(task: task)
		sut.removeTask(task: task)

		let result = sut.allTasks().count == 0

		XCTAssertTrue(result, "Результат проверки удаления задания должен быть - True")
	}
	
	func test_getCompletedTasks_shouldBeSuccess() {
		sut.addTasks(tasks: completedTasks)

		let tasks = sut.completedTasks()
		let result = tasks.isEmpty

		XCTAssertFalse(result, "Результат проверки отсутствия выполненных заданий должен быть - False")
	}

	func test_getUncompletedTasks_shouldBeSuccess() {
		sut.addTasks(tasks: uncompletedTasks)

		let tasks = sut.uncompletedTasks()
		let result = tasks.isEmpty

		XCTAssertFalse(result, "Результат проверки отсутствия не выполненных заданий должен быть - False")
	}
}
