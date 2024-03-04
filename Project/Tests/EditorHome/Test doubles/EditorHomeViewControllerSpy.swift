//
//  EditorHomeViewControllerSpy.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 04.03.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class EditorHomeViewControllerSpy: IEditorHomeView {
	private(set) var didCallRender = false
	private(set) var receivedFiles = [MdEditor.EditorHomeModel.ViewModel.RecentFile]()

	func render(viewModel: EditorHomeModel.ViewModel) {
		receivedFiles = viewModel.recentFiles
		didCallRender = true
	}
}
