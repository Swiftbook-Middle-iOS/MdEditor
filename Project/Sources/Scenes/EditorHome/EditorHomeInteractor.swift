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
	func fetchData()
}

protocol IMainMenuDelegate: AnyObject {
	func openFileBrowser()
	func showAbout()
}

final class EditorHomeInteractor: IEditorHomeInteractor {

	// MARK: Dependencies
	private let recentFileManager: IRecentFileManager
	private let presenter: IEditorHomePresenter
	weak var delegate: IMainMenuDelegate?

	// MARK: Initialization
	init(recentFileManager: IRecentFileManager, presenter: IEditorHomePresenter) {
		self.recentFileManager = recentFileManager
		self.presenter = presenter
	}

	// MARK: IEditorHomeInteractor
	func fetchData() {
		let recentFiles = recentFileManager.getRecentFiles()
		let response = EditorHomeModel.Response(recentFiles: recentFiles)
		presenter.present(response: response)
	}

	func menuItemSelected(item: EditorHomeModel.Request.MenuItemSelected) {
		switch item {
		case .newFile:
			return
		case .openFile:
			delegate?.openFileBrowser()
		case .aboutApp:
			delegate?.showAbout()
		}
	}
}
