//
//  PDFViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 26.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit
import PDFKit

final class PDFViewController: UIViewController {

	// MARK: Dependencies

	// MARK: Private properties
	private var pdfView = PDFView()
	private let data: Data

	init(data: Data) {
		self.data = data
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Lifecyle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Pdf view"

		pdfView.autoScales = true
		pdfView.pageBreakMargins = UIEdgeInsets(top: 32, left: 16, bottom: 16, right: 16)
		pdfView.document = PDFDocument(data: data)

		setupView()
	}

	// MARK: Private methods
	private func setupView() {
		if let navigationBarY = navigationController?.navigationBar.frame.maxY {
			pdfView.frame = CGRect(
				x: 0,
				y: navigationBarY,
				width: view.bounds.width,
				height: view.bounds.height - navigationBarY
			)
		}
		view.addSubview(pdfView)
	}
}
