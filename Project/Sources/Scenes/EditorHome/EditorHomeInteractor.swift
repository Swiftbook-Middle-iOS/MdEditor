//
//  EditorHomeInteractor.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IEditorHomeInteractor {
	func menuItemSelected(item: EditorHomeModel.Request.MenuItemSelected)
}

protocol IMainMenuDelegate: AnyObject {
	func openFileBroweser()
	func showAbout()
}

final class EditorHomeInteractor: IEditorHomeInteractor {
	// MARK: Dependencies

	weak var delegate: IMainMenuDelegate?

	// MARK: IEditorHomeInteractor
	func menuItemSelected(item: EditorHomeModel.Request.MenuItemSelected) {
		switch item {
		case .newFile:
			return
		case .openFile:
			delegate?.openFileBroweser()
		case .aboutApp:
			delegate?.showAbout()
		}
	}
}
