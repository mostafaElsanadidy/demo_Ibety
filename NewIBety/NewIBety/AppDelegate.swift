//
//  AppDelegate.swift
//  NewIBety
//
//  Created by mostafa elsanadidy on 9/20/19.
//  Copyright © 2019 mostafa elsanadidy. All rights reserved.
//

import UIKit
import IQKeyboardManager
import FacebookCore
import FBSDKShareKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var ownerLoginResult:OwnerLogin_Result!
    
    var window: UIWindow?
    
    var index = 0
    
    var storyboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
    func registerDefaults() {
        
        instantiateTabBarViewController()
        let dictionary: [String: Any] = [ "UserRegisteration1" : Data() ,"UserResult" : Data(), "PAGENAME": "", "IsEnterBackGround": false ]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    
    var isBecomeInBack:Bool{
        get{
            return UserDefaults.standard.bool(forKey: "IsEnterBackGround")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "IsEnterBackGround")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerDefaults()
        
        L102Language.setAppleLAnguageTo(lang: "ar")
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        //
        L012Localizer.DoTheSwizzling()
        
        //        let locale = NSLocale.current.languageCode
        //        LanguageManager.init().setLanguage(language: Languages(rawValue: locale ?? "ar")! )
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        let tintColor = #colorLiteral(red: 0.46134305, green: 0.05758429319, blue: 0.2152851522, alpha: 0.8457278481)
        
        UITabBar.appearance().tintColor = tintColor
        
        isBecomeInBack = true
        
        let indexOfPage = UserDefaults.standard.object(forKey: "PAGENAME") as! String
        print("\(isBecomeInBack) mostafa \(indexOfPage)")
        
        
        if isBecomeInBack && (indexOfPage == "MyDetailsViewController" || indexOfPage == "FirstTABViewController"){
            
            tabBarViewController.selectedIndex = 0
            
            window?.rootViewController = tabBarViewController
            
        }
        
        isBecomeInBack = false
        IQKeyboardManager.shared().isEnabled = true
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let appId: String = Settings.appID
        print(appId)
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return false
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
        
        //AppEventsLogger.activate(application)
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func instantiateTabBarViewController(){
        
        tabBarViewController = storyboard.instantiateViewController(
            withIdentifier: "TabBarViewController") as! UITabBarController
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
        // viewController.indexOfPage = 0
        
        let viewController2 = storyboard.instantiateViewController(withIdentifier: "FirstTABViewController") as! FirstTABViewController
        
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            
            let viewController3 = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            tabBarViewController.viewControllers!.insert(viewController3, at: 1)
            tabBarViewController.viewControllers![1].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "User-2"), tag: 1)
            
            let viewController2 = storyboard.instantiateViewController(withIdentifier: "ThirdTabViewController1") as! ThirdTabViewController
            viewController2.indexOfPage = 7
            
            tabBarViewController.viewControllers!.insert(viewController2, at: 2)
            tabBarViewController.viewControllers![2].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Bell"), selectedImage: UIImage(named: "Bell-1"))
            
            print(ownerLoginResult.data!.type!)
            
            
            if ownerLoginResult.data!.type! == "owner" && ownerLoginResult.data!.verified!{
                viewController.indexOfPage = 2
            }
            else if ownerLoginResult.data!.type! == "customer" ||  !ownerLoginResult.data!.verified!{
                
                viewController.indexOfPage = 1
            }
            
            tabBarViewController.viewControllers!.insert(viewController, at: 3)
            tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), selectedImage: UIImage(named: "Group-1"))
            
            index = 3
        }
        else{
            
            viewController.indexOfPage = 0
            tabBarViewController.viewControllers!.insert(viewController, at: 1)
            tabBarViewController.viewControllers![1].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
            index = 1
        }
        
    }
}

