//
//  SceneDelegate.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/15/22.
//

import UIKit
import Resolver


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
      let viewController = AppViewController(
        store:
            .init(initialState: AppState(),
                  reducer: appReducer,
                  environment: .live())
      )

        let navigationView = viewController
        window?.rootViewController = navigationView
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
// snowflag
// jengas framework
}

