//
//  AboutScreenAssembly.swift
//  MdEditor
//
//  Created by Александр Касьянов on 05.02.2024.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class AboutScreenAssembly {
	func assembly(
		fileExplorer: IFileExplorer,
		currentPath: String
	) -> AboutScreenViewController {
		let viewController = AboutScreenViewController()
		let presenter = AboutScreenPresenter(viewController: viewController)
		let interactor = AboutScreenInteractor(
			fileExplorer: fileExplorer,
			currentPath: currentPath,
			presenter: presenter
		)

		viewController.interactor = interactor
		return viewController
	}
}
