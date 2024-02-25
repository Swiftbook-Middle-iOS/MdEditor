//
//  AboutAppTextViewController.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

final class AboutAppTextViewController: UIViewController {

	// MARK: Private properties
	private let textView = UITextView()
	private let attributedText: NSAttributedString

	init(attributedText: NSAttributedString) {
		self.attributedText = attributedText
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Lifecyle
	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = "Text View"
		textView.attributedText = attributedText
		setupView()
	}

	// MARK: Private methods
	private func setupView() {
		if let navigationBarY = navigationController?.navigationBar.frame.maxY {
			textView.frame = CGRect(
				x: 0,
				y: navigationBarY,
				width: view.bounds.width,
				height: view.bounds.height - navigationBarY
			)
		}
		view.addSubview(textView)
	}
}
