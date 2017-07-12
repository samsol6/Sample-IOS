//
//  AppDelegate.swift
//  RezList
//
//  Created by user 1 on 05/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        
        
        
        self.tabBarController = UITabBarController()
//        self.tabBarController?.tabBar.frame = CGRect(x:0, y:0,width:screenWidth, height:50)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = HomeViewController()
        let searchVc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        searchVc.tabBarItem.title = "search"
//        searchVc.tabBarItem.image = UIImage(named: "person.png")?.withRenderingMode(.alwaysOriginal)
//        searchVc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let profileVc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        profileVc.tabBarItem.title = "profile"
//        profileVc.tabBarItem.image = UIImage(named: "icon-bell.png")?.withRenderingMode(.alwaysOriginal)
//        profileVc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        
        let filterVc = FilterViewController(nibName: "FilterViewController", bundle: nil)
        filterVc.tabBarItem.title = "Filter"
        
        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        dashboardVC.tabBarItem.title = "Dashboard"
        
        let notificationVc = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notificationVc.tabBarItem.title = "notification"
        
        let settingVc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        settingVc.tabBarItem.title = "setting"
        
        let supportVc = SupportViewController(nibName: "SupportViewController", bundle: nil)
        supportVc.tabBarItem.title = "setting"
        
        let flatCalVc = FlatFeeCalculatorViewController(nibName: "FlatFeeCalculatorViewController", bundle: nil)
        flatCalVc.tabBarItem.title = "calculator"
        
        let feCal = FeeCalculatorViewController(nibName: "FeeCalculatorViewController", bundle: nil)
        feCal.tabBarItem.title = "calculator"

        let controllers = [ dashboardVC,notificationVc, searchVc, feCal, filterVc]
        //notificationVc, profileVc, filterVc, dashboardVC,
        tabBarController?.viewControllers = controllers
//        window?.rootViewController = tabBarController
        
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

