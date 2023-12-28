import XCTest
@testable import TaskManagerPackage

final class TaskManagerPackageTests: XCTestCase {
	///Создание тестового задания
	let task = Task(title: "Test task")

	///Инъекция класса TaskManager
	var sut: TaskManager!

	///Создание нескольких тестовых заданий
	var tasks: [Task] {
		[task, task]
	}

	///Создание нескольких выполненных тестовых заданий
	var completedTasks: [Task] {
		[
			Task(title: "Test task", completed: true),
			Task(title: "Test task", completed: true)
		]
	}

	///Создание нескольких не выполненных тестовых заданий
	var uncompletedTasks: [Task] {
		[
			Task(title: "Test task", completed: false),
			Task(title: "Test task", completed: false)
		]
	}

	///Создание переменной возвращающей результат проверки на отсутствие заданий
	var isEmpty: Bool {
		sut.allTasks().isEmpty
	}

	///Создание переменной возвращающей количество заданий
	var count: Int {
		sut.allTasks().count
	}

	override func setUp() {
		super.setUp()
		sut = TaskManager()
	}

	override func tearDown() {
		sut = nil
		super.tearDown()
	}

	///Тестирование функции добавления одного задания
	func test_addOneTask_shouldBeSuccess() {
		sut.addTask(task: task)

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия задания должен быть - False")
	}

	///Тестирование функции добавления нескольких заданий
	func test_addOneTasks_shouldBeSuccess() {
		sut.addTasks(tasks: tasks)

		let result = count > 1

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия заданий должен быть - False")
		XCTAssertTrue(result, "Результат проверки добавления задания должен быть - True")
	}

	///Тестирование функции получения всех заданий
	func test_getAllTasks_shouldBeSuccess() {
		sut.addTasks(tasks: tasks)

		let result = tasks.count == sut.allTasks().count

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия заданий должен быть - False")
		XCTAssertTrue(result, "Результат проверки получения заданий должен быть - True")
	}

	///Тестирование функции удаления одного задания
	func test_removeTask_shouldBeSuccess() {
		sut.addTask(task: task)
		sut.removeTask(task: task)

		XCTAssertTrue(isEmpty, "Результат проверки отсутствия задания после удаления должен быть - True")
	}
	
	///Тестирование функции получения всех выполненных заданий
	func test_getCompletedTasks_shouldBeSuccess() {
		sut.addTasks(tasks: completedTasks)

		let result = sut.completedTasks().contains(where: { $0.completed })

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия задания должен быть - False")
		XCTAssertTrue(result, "Результат наличия выполненных заданий должен быть - True")
	}

	///Тестирование функции получения всех не выполненных заданий
	func test_getUncompletedTasks_shouldBeSuccess() {
		sut.addTasks(tasks: uncompletedTasks)

		let result = sut.uncompletedTasks().contains(where: { !$0.completed })

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия задания должен быть - False")
		XCTAssertTrue(result, "Результат наличия не выполненных заданий должен быть - True")
	}
}
