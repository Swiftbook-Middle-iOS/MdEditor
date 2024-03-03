//
//  TaskScanner.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 26.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
import TaskManagerPackage
import MarkdownPackage

final class TaskScanner: ITaskRepository {

	private let document: Document

	init(document: Document) {
		self.document = document
	}

	func getTasks() -> [TaskManagerPackage.Task] {
		scan(document: document)
	}
}

private extension TaskScanner {
	func scan(document: Document) -> [Task] {
		var result = [Task]()

		document.children.forEach { node in
			if let task = node as? TaskNode {
				result.append(taskNodeToRegularTask(taskNode: task))
			}
		}

		return result
	}

	func taskNodeToRegularTask(taskNode: TaskNode) -> RegularTask {
		let text = AttributedConverter().convertTaskNode(node: taskNode)
		return RegularTask(title: text.string, completed: taskNode.isDone)
	}
}
