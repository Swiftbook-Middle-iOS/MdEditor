//
//  EditorHomeInteractor.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IEditorHomeInteractor {
	func openDocumentSelected()
	func openAboutSelected()
}

final class EditorHomeInteractor: IEditorHomeInteractor {
	var openFileClosure: (() -> Void)?

	init(openFileClosure: (() -> Void)? = nil) {
		self.openFileClosure = openFileClosure
	}

	func openDocumentSelected() {
		openFileClosure?()
	}

	func openAboutSelected() {

	}
}
