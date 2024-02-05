//
//  AboutAppAssembler.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

final class AboutAppAssembler {
	func assembly(fileExplorer: IFileExplorer) throws -> AboutAppViewController {
		let viewController = AboutAppViewController()
		let aboutFile = try fileExplorer.getFile(
			withName: L10n.AboutApp.aboutFileName,
			atPath: L10n.FileBrowser.baseAssetsPath
		)

		viewController.labelText = try aboutFile.loadFileBody()
		return viewController
	}
}
