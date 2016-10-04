//
//  AppDelegate.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
//import OpenSansSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //OpenSans.registerFonts()

        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1)
        }
        
        // Nav bar settings
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.shadowImage = UIImage()
        navigationBarAppearace.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearace.backgroundColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1)
        
        navigationBarAppearace.tintColor = UIColor.white
        //navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName: UIFont.openSansFontOfSize(18)]

        var navBarItem = UIBarButtonItem.appearance()
        //navBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.openSansFontOfSize(15)], for: UIControlState())
        
        var tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1)
        tabBarAppearance.backgroundImage = UIImage()

        var swithAppearance = UISwitch.appearance()
        swithAppearance.onTintColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1)




        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

