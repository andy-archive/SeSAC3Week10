//
//  SceneDelegate.swift
//  SeSAC3Week10
//
//  Created by Taekwon Lee on 2023/09/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let firstNav = UINavigationController(rootViewController: SearchViewController())
        let secondNav = UINavigationController(rootViewController: PhotoViewController())
        let thirdNav = UINavigationController(rootViewController: BeerListViewController())
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.backgroundColor = .systemGray4
        tabBarController.setViewControllers([firstNav, secondNav, thirdNav], animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].image = UIImage(systemName: "magnifyingglass")
            items[0].selectedImage = UIImage(systemName: "plus.magnifyingglass")
            items[0].title = "Search"
            
            items[1].image = UIImage(systemName: "photo.stack")
            items[1].selectedImage = UIImage(systemName: "photo.stack.fill")
            items[1].title = "Photo"
            
            items[2].image = UIImage(systemName: "mug")
            items[2].selectedImage = UIImage(systemName: "mug.fill")
            items[2].title = "Beer"
            
        }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

