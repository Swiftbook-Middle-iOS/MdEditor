//
//  RecentFileCollectionViewCell.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

final class RecentFileCollectionViewCell: UICollectionViewCell {

	static let reusableIdentifier = "MenuTableViewCell"

	// MARK: - Private properties

	private lazy var viewCover = makeColoredView()
	private lazy var labelPreviewText = makeMultilineLabel()
	private lazy var labelTitle = makeCenterAlignedLabel()

	private let viewCoverHeight: CGFloat = 140
	private let viewCoverWidth: CGFloat = 90

	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)

		layout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(fileName: String, previewText: String) {
		viewCover.backgroundColor = textToColor(previewText)
		labelPreviewText.text = previewText
		labelTitle.text = fileName
	}
}

private extension RecentFileCollectionViewCell {
	func textToColor(_ text: String) -> UIColor {
		let colors = [
			Colors.red,
			Colors.blue,
			Colors.green
		]

		return colors[text.count % 3]
	}
}

// MARK: - UI setup

private extension RecentFileCollectionViewCell {
	func makeColoredView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}

	func makeMultilineLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Theme.backgroundColor
		label.font = UIFont.preferredFont(forTextStyle: .caption2)
		label.numberOfLines = 0
		label.adjustsFontForContentSizeCategory = true

		return label
	}

	func makeCenterAlignedLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Theme.mainColor
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .caption2)
		label.adjustsFontForContentSizeCategory = true

		return label
	}
}

// MARK: - Layout UI

private extension RecentFileCollectionViewCell {
	func layout() {
		addSubview(viewCover)
		viewCover.addSubview(labelPreviewText)
		addSubview(labelTitle)

		NSLayoutConstraint.activate([
			viewCover.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Padding.normal),
			viewCover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			viewCover.heightAnchor.constraint(equalToConstant: viewCoverHeight),
			viewCover.widthAnchor.constraint(equalToConstant: viewCoverWidth),

			labelPreviewText.leadingAnchor.constraint(equalTo: viewCover.leadingAnchor, constant: Sizes.Padding.normal),
			labelPreviewText.trailingAnchor.constraint(equalTo: viewCover.trailingAnchor, constant: -Sizes.Padding.normal),
			labelPreviewText.topAnchor.constraint(equalTo: viewCover.topAnchor, constant: Sizes.Padding.normal),
			labelPreviewText.bottomAnchor.constraint(equalTo: viewCover.bottomAnchor, constant: -Sizes.Padding.normal),

			labelTitle.topAnchor.constraint(equalTo: viewCover.bottomAnchor, constant: Sizes.Padding.normal),
			labelTitle.leadingAnchor.constraint(equalTo: viewCover.leadingAnchor),
			labelTitle.trailingAnchor.constraint(equalTo: viewCover.trailingAnchor)
		])
	}
}
