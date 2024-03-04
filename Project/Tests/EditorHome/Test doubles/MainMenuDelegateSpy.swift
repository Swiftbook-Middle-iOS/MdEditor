//
//  MainMenuDelegateSpy.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 04.03.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class MainMenuDelegateSpy: IMainMenuDelegate {
	private(set) var didCallOpenFileBrowser = false
	private(set) var didCallShowAbout = false

	func openFileBroweser() {
		didCallOpenFileBrowser = true
	}
	
	func showAbout() {
		didCallShowAbout = true
	}
}
