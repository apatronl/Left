//
//  AppDelegate.swift
//  Left
//
//  Created by Alejandrina Patron on 9/18/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        guard let info = shortcutItem.userInfo else { return }
        guard let recipeName = info["NAME"] as? String else { return }
        guard let recipeURL = info["URL"] as? String else { return }

        openRecipeFromQuickAction(recipeName: recipeName, recipeURL: recipeURL)
        completionHandler(true)
    }
    
    private func openRecipeFromQuickAction(recipeName: String, recipeURL: String) {
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeWebView") as! RecipeWebView
        webView.recipe = RecipeItem(name: recipeName, photo: nil, url: recipeURL)
        let tabsController = self.window?.rootViewController as! UITabBarController
        tabsController.selectedIndex = 1
        let favsTab = tabsController.viewControllers?[1] as! UINavigationController
        favsTab.popToRootViewController(animated: true)
        favsTab.pushViewController(webView, animated: true)
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
