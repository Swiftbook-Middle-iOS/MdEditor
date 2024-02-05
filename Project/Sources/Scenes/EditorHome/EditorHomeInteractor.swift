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
	func aboutAppSelected()
}

final class EditorHomeInteractor: IEditorHomeInteractor {
	// MARK: Dependencies
	var openFileClosure: (() -> Void)?
	var aboutAppClosure: (() -> Void)?

	// MARK: Initialization
	init(openFileClosure: (() -> Void)? = nil, aboutAppClosure: (() -> Void)?) {
		self.openFileClosure = openFileClosure
		self.aboutAppClosure = aboutAppClosure
	}

	// MARK: IEditorHomeInteractor
	func openDocumentSelected() {
		openFileClosure?()
	}

	func aboutAppSelected() {
		aboutAppClosure?()
	}
}
