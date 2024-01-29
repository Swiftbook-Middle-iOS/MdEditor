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

        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        self.window = window
    }

    private func buildTaskManager() -> ITaskManager {
        let taskManager = TaskManager()
        let repository = TaskRepositoryStub()
        let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
        orderedTaskManager.addTasks(tasks: repository.getTasks())

        return orderedTaskManager
    }
}
