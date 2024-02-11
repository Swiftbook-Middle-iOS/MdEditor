//
//  EditorHomeScreenObject.swift
//  MdEditorUITests
//
//  Created by Aleksandr Mamlygo on 08.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class EditorHomeScreenObject: BaseScreenObject {
	
	private lazy var newDocumentButton = app.buttons[AccessibilityIdentifier.newDocumentButton.description]
	private lazy var openFileButton = app.buttons[AccessibilityIdentifier.openFileButton.description]
	private lazy var aboutButton = app.buttons[AccessibilityIdentifier.aboutAppButton.description]

	@discardableResult
	func isEditorHomeScreen() -> Self {
		checkTitle(contains: L10n.EditorHome.title)
		assert(newDocumentButton, [.exists])
		assert(openFileButton, [.exists])
		assert(aboutButton, [.exists])
		return self
	}
}
