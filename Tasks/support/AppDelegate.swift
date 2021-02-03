//
//  AppDelegate.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/13/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit
import FBSDKLoginKit
//import GoogleSignIn
import Alamofire
import SwiftyJSON
import SideMenu
import FBSDKCoreKit

@UIApplicationMain

class AppDelegate: UIResponder,
UIApplicationDelegate//,GIDSignInDelegate {
{
    var window: UIWindow?
    var navigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
      //  GIDSignIn.sharedInstance().clientID = "287317820544-2jop4370263405pgcn1nsli862i6tft0.apps.googleusercontent.com"
      //  GIDSignIn.sharedInstance().delegate = self
//        let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
//        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuController)
//        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
//        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
//        // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
//        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
//
//        // Enable gestures. The left and/or right menus must be set up above for these to work.
//        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.window!)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.window!)
        
        
        
        // save data in user defult to login automatic
        let def = UserDefaults.standard
        if let email = def.object(forKey: "email") as? String
        
        // Loads the menu
        {
            print("email:\(email)")
            
           let tab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController")
            window?.rootViewController = tab
        }
       
        

        // Override point for customization after application launch.
        return ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    // fun for Google Sign in
    
    func application(_ application: UIApplication,
                     open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool{
   return true// GIDSignIn.sharedInstance().handle(url,
//    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//    annotation: options[UIApplicationOpenURLOptionsKey.annotation] as? String)
}
     // fun for Google Sign in
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//        if let error = error {
//            print("\(error.localizedDescription)")
//        } else {
//            // Perform any operations on signed in user here.
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
//
//            print(user.profile.email)
//
//            print(user.userID)
//
//            print(user.profile.name)
//            API.register(name: user.profile.name , email: user.profile.email, password: user.userID){(error :Error? , success : Bool,state :Bool) in
//                if success{
//                    print("OK")
////                    let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
////                   // navigationController.viewControllers = [navigationController.storyboard?.instantiateViewController(withIdentifier: "main")] as! [UIViewController]
////                    UIApplication.shared.keyWindow?.rootViewController = navigationController.storyboard!.instantiateViewController(withIdentifier: "main")
////
//                    guard let window = UIApplication.shared.keyWindow else { return}
//                    let sb = UIStoryboard(name: "Main", bundle: nil)
//                    var vc : UIViewController
//                    vc = sb.instantiateViewController(withIdentifier: "HomeNavigationController")
//                    window.rootViewController = vc
//                    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
//
//                }
//                else
//                {
//                    print("notOK")
//                    // say any thing
//                }
//
//            }
//
//        }
//        }
//
//
//    // fun for Google Sign in
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//              withError error: Error!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//    }
//
//
func applicationWillResignActive(_ application: UIApplication) {
    AppEvents.activateApp()
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
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


