//
//  SceneDelegate.swift

import UIKit
import TaskManagerPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Public properties
    var window: UIWindow?
    private var appCoordinator: ICoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)

        let navigationController = UINavigationController()

        #if DEBUG
        if CommandLine.arguments.contains(CommandLineArguments.skipLogin.rawValue) {
            window.rootViewController =
            UINavigationController(
                rootViewController: TodoListAssembler(
                    taskManager: buildTaskManager()
                )
                .assembly()
            )
            window.makeKeyAndVisible()
            self.window = window
        }
        #endif

        guard window.rootViewController == nil else { return }

        appCoordinator = AppCoordinator(navigationController: navigationController, taskManager: buildTaskManager())
        appCoordinator.start()

        self.window = window
    }
}
