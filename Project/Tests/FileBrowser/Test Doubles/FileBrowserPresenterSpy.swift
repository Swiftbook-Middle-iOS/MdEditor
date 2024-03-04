//
//  FileBrowserPresenterSpy.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class FileBrowserPresenterSpy: IFileBrowserPresenter {

	private(set) var didCallPresent = false
	private(set) var receivedFiles = [File]()

	func present(response: MdEditor.FileBrowserModel.Response) {
		receivedFiles = response.files
		didCallPresent = true
	}
}
