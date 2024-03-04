//
//  EditorHomeAssembly.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class EditorHomeAssembly {
	func assembly(recentFileManager: IRecentFileManager) -> (EditorHomeViewController, EditorHomeInteractor) {
		let viewController = EditorHomeViewController()
		let presenter = EditorHomePresenter(view: viewController)
		let interactor = EditorHomeInteractor(recentFileManager: recentFileManager, presenter: presenter)

		viewController.interactor = interactor
		return (viewController, interactor)
	}
}
