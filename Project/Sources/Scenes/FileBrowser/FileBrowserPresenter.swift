//
//  FileBrowserPresenter.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IFileBrowserPresenter {
}

final class FileBrowserPresenter: IFileBrowserPresenter {

	private weak var viewController: IFileBrowserViewController!

	init(viewController: IFileBrowserViewController) {
		self.viewController = viewController
	}
}
