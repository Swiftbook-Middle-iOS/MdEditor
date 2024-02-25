//
//  AboutInfoViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit
import WebKit
import MarkdownPackage

final class AboutAppViewController: UIViewController, WKNavigationDelegate {

	// MARK: Dependencies
	var htmlText: String
	var parser: Parser! // swiftlint:disable:this implicitly_unwrapped_optional
	var lexer: Lexer! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: Private properties
	private var webView = WKWebView()

	init(htmlText: String) {
		self.htmlText = htmlText
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Lifecyle
	override func viewDidLoad() {
		super.viewDidLoad()
		webView.navigationDelegate = self
		view = webView

		loadPage(html: htmlText)
	}

	// MARK: Private methods
	private func loadPage(url: URL) {
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
	}

	private func loadPage(html: String) {
		webView.loadHTMLString(html, baseURL: nil)
		webView.allowsBackForwardNavigationGestures = false
	}
}
