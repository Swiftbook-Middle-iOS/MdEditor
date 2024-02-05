//
//  AboutScreenInteractor.swift
//  MdEditor
//
//  Created by Александр Касьянов on 05.02.2024.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IAboutScreenInteractor {}

final class AboutScreenInteractor: IAboutScreenInteractor {
	
	// MARK: Dependencies
	private var fileExplorer: IFileExplorer
	private var currentPath: String
	private var presenter: IAboutScreenPresenter

	// MARK: Initialization
	init(
		fileExplorer: IFileExplorer,
		currentPath: String,
		presenter: IAboutScreenPresenter
	) {
		self.fileExplorer = fileExplorer
		self.currentPath = currentPath
		self.presenter = presenter
	}
}
