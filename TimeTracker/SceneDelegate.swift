//
//  SceneDelegate.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        prepareWindow(for: scene as? UIWindowScene)
    }
}

// MARK: Window Preparation

private extension SceneDelegate {
    func prepareWindow(for windowScene: UIWindowScene?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let store = UserDefaultsLoggedTimeStore(userDefaults: UserDefaults())
        let timerContext = OneSecondPulseTimerContext()
        let viewModel = MainViewModel(timerContext: timerContext, loggedTimeStore: store)
        let rootViewController = MainViewController(viewModel: viewModel)
        rootViewController.title = "Time Tracker"
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
