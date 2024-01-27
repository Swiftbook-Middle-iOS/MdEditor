//
//  TodoListScreenObject.swift
//  MdEditorUITests
//
//  Created by Aleksandr Mamlygo on 27.01.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest

final class TodoListScreenObject: BaseScreenObject {
    
    // MARK: Private properties
    
    private lazy var tableView = app.tables.matching(identifier: AccessibilityIdentifier.todoListTableView.rawValue).element
    
    
    // MARK: ScreenObject methods
    
    @discardableResult
    func isTodoListScreen() -> Self {
        assert(tableView, [.exists])
        return self
    }
}


