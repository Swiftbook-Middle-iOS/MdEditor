//
//  FileBrowserInteractorSpy.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class FileBrowserInteractorSpy: IFileBrowserInteractor {

	private(set) var didCallFetchData = false
	private(set) var selectedItem: Int?

	func fetchData() {
		didCallFetchData = true
	}

	func didSelectItem(at index: Int) {
		selectedItem = index
	}
}
