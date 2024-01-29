//
//  AccessibilityIdentifier.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 27.01.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

enum AccessibilityIdentifier {
    case todoListTableView
    case cell(section: Int, index: Int)
    case sectionLabel(section: Int)
    
    case textFieldLogin
    case textFieldPass
    case buttonLogin
    
    var description: String {
        switch self {
        case .todoListTableView:
            return "todoListTableView"
        case .cell(let section, let index):
            return "cell-\(section)-\(index)"
        case .sectionLabel(let section):
            return "sectionLabel-\(section)"
        case .textFieldLogin:
            return "textFieldLogin"
        case .textFieldPass:
            return "textFieldPass"
        case .buttonLogin:
            return "loginButton"
        }
    }
}
