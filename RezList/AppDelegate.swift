//
//  AppDelegate.swift
//  RezList
//
//  Created by user 1 on 05/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.

        // iOS 10 support
//        if #available(iOS 10, *) {
//            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
//            application.registerForRemoteNotifications()
//        }
//            // iOS 9 support
//        else if #available(iOS 9, *) {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//            // iOS 8 support
//        else if #available(iOS 8, *) {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//            // iOS 7 support
//        else {  
//            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
//        }
        
        
        //end
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        
        
        
        self.tabBarController = UITabBarController()
//        self.tabBarController?.tabBar.frame = CGRect(x:0, y:0,width:screenWidth, height:50)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = HomeViewController()
        let searchVc = SearchViewController(nibName: "SearchViewController", bundle: nil)
//        searchVc.tabBarItem.title = "search"
//        searchVc.tabBarItem.image = UIImage(named: "person.png")?.withRenderingMode(.alwaysOriginal)
//        searchVc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let profileVc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
//        profileVc.tabBarItem.title = "profile"
//        profileVc.tabBarItem.image = UIImage(named: "icon-bell.png")?.withRenderingMode(.alwaysOriginal)
//        profileVc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        
        let filterVc = FilterViewController(nibName: "FilterViewController", bundle: nil)
//        filterVc.tabBarItem.title = "Filter"
        
        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
//        var customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "logo.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "logo.png"))
//        dashboardVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "logo"), selectedImage: UIImage(named: "logo"))
//        dashboardVC.tabBarItem = customTabBarItem
//        dashboardVC.tabBarItem.title = "Dashboard"
        
        let notificationVc = NotificationSettingViewController(nibName: "NotificationSettingViewController", bundle: nil)
//        notificationVc.tabBarItem.title = "notification"
        
        let settingVc = SettingViewController(nibName: "SettingViewController", bundle: nil)
//        settingVc.tabBarItem.title = "setting"
        
        let supportVc = SupportViewController(nibName: "SupportViewController", bundle: nil)
//        supportVc.tabBarItem.title = "setting"
        
        let flatCalVc = FlatFeeCalculatorViewController(nibName: "FlatFeeCalculatorViewController", bundle: nil)
//        flatCalVc.tabBarItem.title = "calculator"
        
        let feCal = FeeCalculatorViewController(nibName: "FeeCalculatorViewController", bundle: nil)
//        feCal.tabBarItem.title = "calculator"

        let controllers = [ searchVc, notificationVc, dashboardVC, flatCalVc, supportVc]
        //notificationVc, profileVc, filterVc, dashboardVC,
        tabBarController?.viewControllers = controllers
        
        //first controller
        self.tabBarController?.tabBar.items?[0].image = UIImage(named: "searchTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[0].selectedImage = UIImage(named: "searchTab")?.withRenderingMode(.alwaysOriginal)

        self.tabBarController?.tabBar.items?[0].imageInsets = UIEdgeInsets(top: 4, left: -4, bottom: -4, right: 4)
        
        
        //2nd controller
        self.tabBarController?.tabBar.items?[1].image = UIImage(named: "white_bellTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[1].selectedImage = UIImage(named: "white_bellTab")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarController?.tabBar.items?[1].imageInsets = UIEdgeInsets(top: 4, left: -4, bottom: -4, right: 4)
        
        //3rd controller
        self.tabBarController?.tabBar.items?[2].image = UIImage(named: "contactTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].selectedImage = UIImage(named: "contactTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].imageInsets = UIEdgeInsets(top: 4, left: -4, bottom: -4, right: 4)
        
        //4th controller
        self.tabBarController?.tabBar.items?[3].image = UIImage(named: "calculatorTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[3].selectedImage = UIImage(named: "calculatorTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[3].imageInsets = UIEdgeInsets(top: 4, left: -4, bottom: -4, right: 4)
        
        //5th controller
        self.tabBarController?.tabBar.items?[4].image = UIImage(named: "settingTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[4].selectedImage = UIImage(named: "settingTab")?.withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[4].imageInsets = UIEdgeInsets(top: 4, left: -4, bottom: -4, right: 4)
        
        // tabbar controller
        self.tabBarController?.delegate = self
//        self.tabBarController?.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        
//        window?.rootViewController = tabBarController
        
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        let isRegisteredForLocalNotifications = UIApplication.shared.currentUserNotificationSettings?.types.contains(UIUserNotificationType.alert) ?? false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let isRegisteredForLocalNotifications = UIApplication.shared.currentUserNotificationSettings?.types.contains(UIUserNotificationType.alert) ?? false
    }
//    -(void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
//    {
//    if (notificationSettings.types) {
//    NSLog(@"user allowed notifications");
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }else{
//    NSLog(@"user did not allow notifications");
//    // show alert here
//    }
//    }
    
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

