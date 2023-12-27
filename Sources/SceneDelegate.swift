//
//  SceneDelegate.swift

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	// MARK: - Public properties

	var window: UIWindow?

	// MARK: - Lifecycle

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		let mainViewController = UIViewController()
		
		window.rootViewController = mainViewController
		window.makeKeyAndVisible()

		self.window = window
	}
}
