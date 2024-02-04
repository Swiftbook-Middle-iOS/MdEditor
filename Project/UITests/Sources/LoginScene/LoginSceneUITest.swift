//
//  LoginSceneUITest.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 03.04.2023.
//

import XCTest

final class LoginSceneUITest: XCTestCase {
	
	private let app = XCUIApplication()
	private var loginScreen: LoginScreenObject!

	private enum LoginCredentials {
		static let valid: (login: String, password: String) = ("Admin", "pa$$32!")
		static let invalid: (login: String, password: String) = ("wrongLogin", "wrongPass")
	}

	override func setUp() {
		loginScreen = LoginScreenObject(app: app)
	}
	
	override func tearDown() {
		// Taking screenshot after test
		let screenshot = XCUIScreen.main.screenshot()
		let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
		fullScreenshotAttachment.name = "Fail test"
		fullScreenshotAttachment.lifetime = .deleteOnSuccess
		add(fullScreenshotAttachment)
	}
	
	func test_login_withValidCred_mustBeSuccess() {
		app.launch()
		let todoListScreenObject = TodoListScreenObject(app: app)

		loginScreen
			.isLoginScreen()
			.set(password: LoginCredentials.valid.password)
			.set(login: LoginCredentials.valid.login)
			.login()

		todoListScreenObject.isTodoListScreen()
	}
	
	func test_login_withInvalidPassword_mustBeSuccess() {
		app.launch()
		
		loginScreen
			.isLoginScreen()
			.set(password: LoginCredentials.invalid.password)
			.set(login: LoginCredentials.valid.login)
			.login()
			.handleAlert(withExpectedError: L10n.LoginError.wrongPassword)
			.isLoginScreen()
	}
	
	func test_login_withInvalidLogin_mustBeSuccess() {
		app.launch()
		
		loginScreen
			.isLoginScreen()
			.set(password: LoginCredentials.valid.password)
			.set(login: LoginCredentials.invalid.login)
			.login()
			.handleAlert(withExpectedError: L10n.LoginError.wrongLogin)
			.isLoginScreen()
	}
	
	func test_login_withInvalidCreds_mustBeSuccess() {
		app.launch()
		
		loginScreen
			.isLoginScreen()
			.set(password: LoginCredentials.invalid.password)
			.set(login: LoginCredentials.invalid.login)
			.login()
			.handleAlert(withExpectedError: L10n.LoginError.errorAuth)
			.isLoginScreen()
	}
	
	func test_login_withEmptyCreds_mustBeSuccess() {
		app.launch()
		
		loginScreen
			.isLoginScreen()
			.set(password: "")
			.set(login: "")
			.login()
			.handleAlert(withExpectedError: L10n.LoginError.emptyFields)
			.isLoginScreen()
	}
}
