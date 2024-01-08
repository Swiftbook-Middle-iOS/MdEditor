import XCTest
@testable import TaskManagerPackage

final class TaskManagerPackageTests: XCTestCase {

	// MARK: - Public properties
	///Создание тестового задания.
	private let task = Task(title: "Test task")

	///Создание нескольких заданий с разными статусами выполнения.
	private let tasksToCheckCompletion = [
		Task(title: "Test task", completed: true),
		Task(title: "Test task", completed: false)
	]

	///Создание нескольких тестовых заданий.
	private var tasks: [Task] {
		[task, task]
	}

	///Создание переменной возвращающей результат проверки на отсутствие заданий.
	private var isEmpty: Bool {
		sut.allTasks().isEmpty
	}

	///Создание переменной возвращающей количество заданий.
	private var count: Int {
		sut.allTasks().count
	}

	// MARK: - Dependencies
	///Инъекция класса TaskManager. (sut - System Under Testing)
	private var sut: TaskManager!

	// MARK: - Lifecycle
	override func setUp() {
		super.setUp()
		sut = TaskManager()
	}

	override func tearDown() {
		sut = nil
		super.tearDown()
	}

	// MARK: - Public methods
	///Тестирование функции добавления одного задания.
	func test_addTask_whenAddingSingleTask_shouldBeSuccess() {
		sut.addTask(task: task)

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия задания должен быть - False")
	}

	///Тестирование функции добавления нескольких заданий.
	func test_addTasks_whenAddingMultipleTasks_shouldBeSuccess() {
		sut.addTasks(tasks: tasks)

		let result = count > 1

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия заданий должен быть - False")
		XCTAssertTrue(result, "Результат проверки добавления задания должен быть - True")
	}

	///Тестирование функции получения всех заданий.
	func test_allTasks_whenTasksAdded_shouldBeSuccess() {
		sut.addTasks(tasks: tasks)

		let result = tasks.count == sut.allTasks().count

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия заданий должен быть - False")
		XCTAssertTrue(result, "Результат проверки получения заданий должен быть - True")
	}

	///Тестирование функции удаления одного задания.
	func test_removeTask_whenTaskRemoved_shouldBeSuccess() {
		sut.addTask(task: task)
		sut.removeTask(task: task)

		XCTAssertTrue(isEmpty, "Результат проверки отсутствия задания после удаления должен быть - True")
	}

	///Тестирование функции получения всех выполненных заданий.
	func test_getCompletedTasks_whenTasksAdded_shouldBeSuccess() {
		sut.addTasks(tasks: tasksToCheckCompletion)

		let result = sut.completedTasks()

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия задания должен быть - False")
		XCTAssertFalse(
			result.contains(where: { !$0.completed }),
			"Результат проверки наличия не выполненных заданий должен быть - False"
		)
	}

	///Тестирование функции получения всех не выполненных заданий.
	func test_getUncompletedTasks_whenTasksAdded_shouldBeSuccess() {
		sut.addTasks(tasks: tasksToCheckCompletion)

		let result = sut.uncompletedTasks()

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия задания должен быть - False")
		XCTAssertFalse(
			result.contains(where: { $0.completed }),
			"Результат проверки наличия выполненных заданий должен быть - False"
		)
	}
}
