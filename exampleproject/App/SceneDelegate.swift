import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Ensure the scene is a UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Initialize the window and root view controller
        let window = UIWindow(windowScene: windowScene)

        // Set up the view model and view controller
        let userService = UserService()
        let userListViewModel = UserListViewModel(service: userService)
        let userListVC = UserListViewController(viewModel: userListViewModel)

        // Embed in navigation controller
        let navigationController = UINavigationController(rootViewController: userListVC)
        window.rootViewController = navigationController

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
