//
//  AppDelegate.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        var vc: UIViewController?
        if UserData.shared.id == nil {
            vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVC") as? UINavigationController
        } else {
            let VC = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            vc = UINavigationController(rootViewController: VC ?? UIViewController())
        }
        guard let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftSideMenu") as? LeftSideMenuController, let centerViewController = vc else { return true }
        
        centerContainer = MMDrawerController(
            center: centerViewController, leftDrawerViewController: leftViewController)
        centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView;
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView;
        window!.rootViewController = centerContainer
        window!.makeKeyAndVisible()
        return true

    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    var centerContainer: MMDrawerController?


}

