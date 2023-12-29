//
//  OrderedTaskManagerPackageTests.swift
//  
//
//  Created by Борис Бахлыков on 29.12.2023.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerPackageTests: XCTestCase {
	///Создание перечисления для удобного использования наименований заданий
	enum TaskTitles: String {
		case regular = "Regular"
		case high = "High"
		case medium = "Medium"
		case low = "Low"
	}

	// MARK: - Public properties
	///Создание тестового задания
	private let task = ImportantTask(title: TaskTitles.high.rawValue, date: .distantPast, taskPriority: .high)

	///Создание нескольких тестовых заданий
	private let tasks = [
		ImportantTask(title: TaskTitles.high.rawValue, date: .distantPast, taskPriority: .high),
		ImportantTask(title: TaskTitles.medium.rawValue, date: .distantPast, taskPriority: .medium),
		ImportantTask(title: TaskTitles.low.rawValue, date: .distantPast, taskPriority: .low),
		RegularTask(title: TaskTitles.regular.rawValue)
	]

	///Создание нескольких заданий с разными статусами выполнения
	private let tasksToCheckCompletion = [
		Task(title: "Test task", completed: true),
		Task(title: "Test task", completed: false)
	]

	///Создание переменной возвращающей результат проверки на отсутствие заданий
	private var isEmpty: Bool {
		sut.allTasks().isEmpty
	}

	// MARK: - Dependencies
	///Инъекция классов OrderedTaskManager и TaskManager
	private var sut: OrderedTaskManager!
	private var taskManager: TaskManager!

	// MARK: - Lifecycle
	override func setUp() {
		super.setUp()
		taskManager = TaskManager()
		sut = OrderedTaskManager(taskManager: taskManager)
	}

	override func tearDown() {
		sut = nil
		taskManager = nil
	}

	// MARK: - Public methods
	///Тестирование функции получения всех отсортированных заданий
	func test_allTasks_whenTasksAdded_ShouldBeSuccess() {
		taskManager.addTasks(tasks: tasks)

		let result = sut.allTasks()

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия значения должен быть - False")
		XCTAssertEqual(
			result.firstIndex(where: { $0.title == TaskTitles.regular.rawValue }),
			tasks.firstIndex(where: { $0.title == TaskTitles.regular.rawValue }), 
			"Результат проверки сортировки должен отобразить равнозначность значений на определенных позициях"
		)
		XCTAssertEqual(
			result.firstIndex(where: { $0.title == TaskTitles.high.rawValue }),
			tasks.firstIndex(where: { $0.title == TaskTitles.high.rawValue }),
			"Результат проверки сортировки должен отобразить равнозначность значений на определенных позициях"
		)
		XCTAssertEqual(
			result.firstIndex(where: { $0.title == TaskTitles.medium.rawValue }),
			tasks.firstIndex(where: { $0.title == TaskTitles.medium.rawValue }),
			"Результат проверки сортировки должен отобразить равнозначность значений на определенных позициях"
		)
		XCTAssertEqual(
			result.firstIndex(where: { $0.title == TaskTitles.low.rawValue }),
			tasks.firstIndex(where: { $0.title == TaskTitles.low.rawValue }),
			"Результат проверки сортировки должен отобразить равнозначность значений на определенных позициях"
		)
	}

	///Тестирование функции получения всех отсортированных выполненных заданий
	func test_completedTasks_whenTasksAdded_ShouldBeSuccess() {
		taskManager.addTasks(tasks: tasksToCheckCompletion)

		let result = sut.completedTasks()

		XCTAssertFalse(
			result.contains(where: { !$0.completed }),
			"Результат проверки наличия не выполненных заданий должен быть - False"
		)
	}

	///Тестирование функции получения всех отсортированных не выполненных заданий
	func test_uncompletedTasks_whenTasksAdded_ShouldBeSuccess() {
		taskManager.addTasks(tasks: tasksToCheckCompletion)

		let result = sut.uncompletedTasks()

		XCTAssertFalse(
			result.contains(where: { $0.completed }),
			"Результат проверки наличия выполненных заданий должен быть - False"
		)
	}

	///Тестирование функции добавления одного задания
	func test_addTask_whenAddingSingleTask_ShouldBeSuccess() {
		taskManager.addTask(task: task)

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия значения должен быть - False")
	}

	///Тестирование функции добавления нескольких заданий
	func test_addTasks_whenAddingMultipleTasks_ShouldBeSuccess() {
		taskManager.addTasks(tasks: tasks)

		XCTAssertFalse(isEmpty, "Результат проверки отсутствия значения должен быть - False")
	}
}
