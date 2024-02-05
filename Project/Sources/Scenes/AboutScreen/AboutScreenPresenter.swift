//
//  AboutScreenPresenter.swift
//  MdEditor
//
//  Created by Александр Касьянов on 05.02.2024.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IAboutScreenPresenter {

}

final class AboutScreenPresenter: IAboutScreenPresenter {

	// MARK: Dependencies
	private weak var viewController: IAboutScreenViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: initialization
	init(viewController: IAboutScreenViewController) {
		self.viewController = viewController
	}
}
