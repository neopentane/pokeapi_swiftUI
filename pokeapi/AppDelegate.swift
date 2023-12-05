//
//  AppDelegate.swift
//  pokeapi
//
//  Created by Shreeram Kelkar on 12/11/23.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

protocol Coordinator: AnyObject {
    func start()
}

class AppCoordinator: Coordinator {
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let launchScreenViewModel = LaunchScreenViewModel()
        let launchScreen = LaunchScreenView(viewModel: launchScreenViewModel)
        let navigationController = UINavigationController(rootViewController: UIHostingController(rootView: launchScreen))
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


class LaunchScreenViewModel: ObservableObject {
    @Published var users: [String] = []

    func fetchUsers() {

    }
}



