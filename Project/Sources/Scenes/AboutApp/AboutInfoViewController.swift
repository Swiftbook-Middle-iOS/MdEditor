//
//  AboutInfoViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit
import WebKit

final class AboutAppViewController: UIViewController, WKNavigationDelegate {

	// MARK: Dependencies
	var mdText: String! // swiftlint:disable:this implicitly_unwrapped_optional
	var markdownCoverter: IMarkdownToHtmlConverter! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: Private properties
	private var webView = WKWebView()

	// MARK: Lifecyle
	override func viewDidLoad() {
		super.viewDidLoad()
		webView.navigationDelegate = self
		view = webView

		let html = markdownCoverter.convert(mdText)
		loadPage(html: html)
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
