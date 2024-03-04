//
//  EditorHomeInteractorSpy.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 04.03.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class EditorHomeInteractorSpy: IEditorHomeInteractor {
	private(set) var didCallFetchData = false
	private(set) var recievedMenuItem: EditorHomeModel.Request.MenuItemSelected!

	func menuItemSelected(item: MdEditor.EditorHomeModel.Request.MenuItemSelected) {
		recievedMenuItem = item
	}
	
	func fetchData() {
		didCallFetchData = true
	}
}


