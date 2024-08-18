//
//  SceneDelegate.swift
//  iOSGeekMVP
//
//  Created by Sanjay Vekariya on 8/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure that we have a UIWindowScene to work with
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Initialize the window with the UIWindowScene
        window = UIWindow(windowScene: windowScene)
        
        // Set the root view controller of the window
        let serviceProvider = UsersServiceProvider()
        let presenter = UsersPresenter(serviceProvider: serviceProvider)
        let viewController = UsersViewController(presenter: presenter)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        
        // Make the window visible
        window?.makeKeyAndVisible()
    }
}

