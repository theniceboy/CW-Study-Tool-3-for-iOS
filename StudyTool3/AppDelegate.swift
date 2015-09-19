//
//  AppDelegate.swift
//  StudyTool3
//
//  Created by David Chen on 9/18/15.
//  Copyright © 2015 David Chen. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func jumpToLogin () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("FrmLogin")
        self.window?.rootViewController = vc
    }
    
    func try_login () {
        let query = PFQuery(className: "users").whereKey("username", equalTo: me.username)
        do {
            let objects = try query.findObjects()
            if (objects.count > 0) {
                for object in objects {
                    if (object["password"] as? String != me.password) {
                        jumpToLogin()
                        break
                    }
                }
            } else {
                jumpToLogin()
            }
        } catch let error as NSError {
            print(error)
        }
        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Parse setup
        Parse.enableLocalDatastore()
        Parse.setApplicationId(ps1, clientKey: ps2)
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // Check login
        if (NSUserDefaults.standardUserDefaults().valueForKey("username") == nil) {
            jumpToLogin()
            return true
        }
        me.username = NSUserDefaults.standardUserDefaults().valueForKey("username") as! String
        me.password = NSUserDefaults.standardUserDefaults().valueForKey("password") as! String
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

