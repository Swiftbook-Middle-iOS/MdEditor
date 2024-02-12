//
//  EditorHomeViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

final class EditorHomeViewController: UIViewController {

	// MARK: Dependencies
	var interactor: IEditorHomeInteractor?

	// MARK: Private properties
	private lazy var newDocumentButton: UIButton = makeButton(
		imageName: L10n.EditorHome.newDocImageName,
		title: L10n.EditorHome.newButtonTitle,
		accessibilityIdentifier: AccessibilityIdentifier.newDocumentButton.description
	)

	private lazy var openFileButton: UIButton = {
		let button = makeButton(
			imageName: L10n.EditorHome.openFileImageName,
			title: L10n.EditorHome.openButtonTitle,
			accessibilityIdentifier: AccessibilityIdentifier.openFileButton.description
		)
		button.addTarget(nil, action: #selector(openDocumentTapped), for: .touchUpInside)
		return button
	}()

	private lazy var aboutButton: UIButton = {
		let button = makeButton(
			imageName: L10n.EditorHome.aboutAppImageName,
			title: L10n.EditorHome.aboutButtonTitle,
			accessibilityIdentifier: AccessibilityIdentifier.aboutAppButton.description
		)
		button.addTarget(nil, action: #selector(aboutAppTapped), for: .touchUpInside)
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	@objc
	func openDocumentTapped() {
		interactor?.openDocumentSelected()
	}

	@objc
	func aboutAppTapped() {
		interactor?.aboutAppSelected()
	}
}

// MARK: Setup UI
private extension EditorHomeViewController {
	func makeButton(imageName: String, title: String, accessibilityIdentifier: String) -> UIButton {
		let button = UIButton()

		button.configuration = .borderless()
		button.configuration?.imagePadding = Sizes.Padding.half
		// TODO: Check why imageReservation isn't visible on xcode 14.2 // swiftlint:disable:this todo
//		button.configuration?.imageReservation = Sizes.Padding.double

		button.configuration?.baseForegroundColor = Theme.black
		button.configuration?.image = UIImage(systemName: imageName)?.withTintColor(
			Theme.mainColor,
			renderingMode: .alwaysOriginal
		)

		button.configuration?.title = title
		button.contentHorizontalAlignment = .leading
		button.configuration?.contentInsets = .init(
			top: Sizes.Padding.normal,
			leading: Sizes.Padding.half,
			bottom: Sizes.Padding.normal,
			trailing: 0
		)

		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
		button.titleLabel?.adjustsFontForContentSizeCategory = true

		button.accessibilityIdentifier = accessibilityIdentifier
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	func setupUI() {
		view.backgroundColor = Theme.white
		title = L10n.EditorHome.title
		navigationController?.navigationBar.prefersLargeTitles = true

		view.addSubview(newDocumentButton)
		view.addSubview(aboutButton)
		view.addSubview(openFileButton)
	}
}

// MARK: Layout UI
private extension EditorHomeViewController {
	func layout() {
		let constraints = [
			newDocumentButton.topAnchor.constraint(
				equalTo: navigationController?.navigationBar.bottomAnchor ?? view.topAnchor,
				constant: Sizes.Padding.double
			),
			newDocumentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			newDocumentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),

			openFileButton.topAnchor.constraint(equalTo: newDocumentButton.bottomAnchor, constant: Sizes.Padding.normal),
			openFileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			openFileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),

			aboutButton.topAnchor.constraint(equalTo: openFileButton.bottomAnchor, constant: Sizes.Padding.normal),
			aboutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			aboutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal)
		]

		NSLayoutConstraint.activate(constraints)
	}
}
