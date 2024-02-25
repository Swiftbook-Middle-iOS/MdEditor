//
//  EditorHomeAssembly.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class EditorHomeAssembly {
	func assembly(delegate: IMainMenuDelegate) -> EditorHomeViewController {
		let viewController = EditorHomeViewController()
		let interactor = EditorHomeInteractor()
		interactor.delegate = delegate

		viewController.interactor = interactor
		return viewController
	}
}
