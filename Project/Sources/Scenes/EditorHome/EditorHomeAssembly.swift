//
//  EditorHomeAssembly.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class EditorHomeAssembly {
	func assembly(openFileClosure: (() -> Void)?) -> EditorHomeViewController {
		let viewController = EditorHomeViewController()
		let interactor = EditorHomeInteractor(openFileClosure: openFileClosure)

		viewController.interactor = interactor
		return viewController
	}
}
