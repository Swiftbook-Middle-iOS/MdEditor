//
//  AboutScreenViewController.swift
//  MdEditor
//
//  Created by Александр Касьянов on 05.02.2024.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

final class AboutScreenViewController: UIViewController {

	// MARK: Dependencies
	var interactor: AboutScreenInteractor?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: Setup UI
private extension AboutScreenViewController {
	func setupUI() {
		view.backgroundColor = Theme.mainColor
		title = L10n.AboutScreen.aboutScreenTitle
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

// MARK: Layout UI
private extension AboutScreenViewController {
	func layout() {
//		let constraints = [
//			newDocumentButton.topAnchor.constraint(
//				equalTo: navigationController?.navigationBar.bottomAnchor ?? view.topAnchor,
//				constant: Sizes.Padding.double
//			),
//			newDocumentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
//			newDocumentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),
//
//			openFileButton.topAnchor.constraint(equalTo: newDocumentButton.bottomAnchor, constant: Sizes.Padding.normal),
//			openFileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
//			openFileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),
//
//			aboutButton.topAnchor.constraint(equalTo: openFileButton.bottomAnchor, constant: Sizes.Padding.normal),
//			aboutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
//			aboutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal)
//		]
//
//		NSLayoutConstraint.activate(constraints)
	}
}
