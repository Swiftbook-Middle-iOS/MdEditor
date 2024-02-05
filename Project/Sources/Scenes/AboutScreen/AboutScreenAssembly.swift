//
//  AboutScreenAssembly.swift
//  MdEditor
//
//  Created by Александр Касьянов on 05.02.2024.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class AboutScreenAssembly {
	func assembly(openFileClosure: (() -> Void)?) -> AboutScreenViewController {
		let viewController = AboutScreenViewController()
		let interactor = AboutScreenInteractor()

		viewController.interactor = interactor
		return viewController
	}
}
