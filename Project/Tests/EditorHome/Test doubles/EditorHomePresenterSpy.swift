//
//  EditorHomePresenterSpy.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 04.03.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class EditorHomePresenterSpy: IEditorHomePresenter {
	private(set) var didCallPresent = false
	private(set) var receivedRecentFiles = [RecentFile]()

	func present(response: MdEditor.EditorHomeModel.Response) {
		didCallPresent = true
		receivedRecentFiles = response.recentFiles
	}
}
