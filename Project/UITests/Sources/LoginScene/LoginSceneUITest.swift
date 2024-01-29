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
    
    override func setUp() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
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
	
		loginScreen
			.isLoginScreen()
			.set(password: "pa$$32!")
			.set(login: "Admin")
			.login()
            .isNotLoginScreen()
	}
    
    func test_login_withInvalidPassword_shouldBeCorrect() {
        app.launch()
    
        loginScreen
            .isLoginScreen()
            .set(password: "invalidpass")
            .set(login: "Admin")
            .login()
            .handleAlert(withExpectedError: "Wrong Password")
            .isLoginScreen()
    }
    
    func test_login_withInvalidLogin_shouldBeCorrect() {
        app.launch()
        
        loginScreen
            .isLoginScreen()
            .set(password: "pa$$32!")
            .set(login: "invalidlogin")
            .login()
            .handleAlert(withExpectedError: "Wrong Login")
            .isLoginScreen()
    }
    
    func test_login_withInvalidCreds_shouldBeCorrect() {
        app.launch()
        
        loginScreen
            .isLoginScreen()
            .set(password: "invalidpass")
            .set(login: "invalidlogin")
            .login()
            .handleAlert(withExpectedError: "Wrong login and password")
            .isLoginScreen()
    }
    
    func test_login_withEmptyCreds_shouldBeCorrect() {
        app.launch()
        
        loginScreen
            .isLoginScreen()
            .set(password: "")
            .set(login: "")
            .login()
            .handleAlert(withExpectedError: "Empty login or password")
            .isLoginScreen()
    }
}
