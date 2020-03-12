//
//  AppDelegate.swift
//  MovieList
//
//  Created by Bhanu Prasad Gollapudi on 03/03/20.
//  Copyright © 2020 Bhanu Prasad Gollapudi. All rights reserved.
//

import UIKit
import SplunkMint
import ADEUMInstrumentation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Mint.sharedInstance().initAndStartSession(withAPIKey: "c6f3e16e")
        ADEumInstrumentation.initWithKey("AD-AAB-AAV-GAB")
        
        let config = ADEumAgentConfiguration(appKey: "AD-AAB-AAV-GAB")
        config.collectorURL = "https://col.eum-appdynamics.com"
       // config.screenshotUrl = "https://image.eum-appdynamics.com"
        ADEumInstrumentation.initWith(config)
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

