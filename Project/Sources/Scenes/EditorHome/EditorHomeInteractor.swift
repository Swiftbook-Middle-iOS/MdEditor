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
	var openFileClosure: (() -> Void)?
	var aboutAppClosure: (() -> Void)?

	init(openFileClosure: (() -> Void)? = nil, aboutAppClosure: (() -> Void)?) {
		self.openFileClosure = openFileClosure
		self.aboutAppClosure = aboutAppClosure
	}

	func openDocumentSelected() {
		openFileClosure?()
	}

	func aboutAppSelected() {
		aboutAppClosure?()
	}
}
