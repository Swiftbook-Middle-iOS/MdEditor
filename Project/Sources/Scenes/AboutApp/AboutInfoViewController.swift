//
//  AboutInfoViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

final class AboutAppViewController: UIViewController {

	private lazy var label: UILabel = makeLabel(text: labelText ?? "")
	var labelText: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		layout()
	}
}

// MARK: Setup UI
private extension AboutAppViewController {
	func setupUI() {
		view.backgroundColor = Theme.white
		view.addSubview(label)
		title = L10n.AboutApp.title
	}

	func makeLabel(text: String) -> UILabel {
		let label = UILabel()
		label.textColor = Theme.black
		label.text = text
		label.numberOfLines = 0
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.lineBreakMode = .byWordWrapping
		label.adjustsFontForContentSizeCategory = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}

// MARK: Layout
private extension AboutAppViewController {
	func layout() {
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(
				equalTo: navigationController?.navigationBar.bottomAnchor ?? view.topAnchor,
				constant: Sizes.Padding.double
			),
			label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal)
		])
	}
}
