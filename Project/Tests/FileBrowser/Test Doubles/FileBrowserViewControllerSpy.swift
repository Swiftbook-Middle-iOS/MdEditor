//
//  FileBrowserViewControllerSpy.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class FileBrowserViewControllerSpy: IFileBrowserViewController {

	private(set) var didCallRender = false
	private(set) var receivedViewModel: MdEditor.FileBrowserModel.ViewModel!

	func render(viewModel: MdEditor.FileBrowserModel.ViewModel) {
		receivedViewModel = viewModel
		didCallRender = true
	}
}
