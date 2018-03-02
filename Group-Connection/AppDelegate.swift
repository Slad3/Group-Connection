//
//  AppDelegate.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/5/17.
//  Copyright © 2017 District196. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        Globals.globals.initialized = recoverOldData()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController: UIViewController
        
        //if-else sequence to determine what UIView to start on based on if unitialized,mentor, and in competition
        if !Globals.globals.initialized { //Initial Profile; only if decoding failed
            initialViewController = storyboard.instantiateViewController(withIdentifier: "Initial Profile VC")
//            //delete
            Globals.globals.user.subteam = "Choose Subteam"
            print(Globals.globals.user.subteam)
        }
        else if !Globals.globals.inEvent {
            if Globals.globals.user.isMentor { //Initial Profile so mentors can choose what view to go to
                initialViewController = storyboard.instantiateViewController(withIdentifier: "Initial Profile VC")
//                //delete
                Globals.globals.user.subteam = "Programming"//"Choose Subteam"
                print(Globals.globals.user.subteam)
            }
            else { //Join; if they're not a mentor
                initialViewController = storyboard.instantiateViewController(withIdentifier: "Join Event VC")
//                //delete
//                Globals.globals.user.subteam = "Choose Subteam"
                print(Globals.globals.user.subteam)
            }
        }
        else if Globals.globals.inEvent { //Main Tab
            initialViewController = storyboard.instantiateViewController(withIdentifier: "Main Tab VC")
        }
        else { //Initial Profile; Only if stuff really goes wrong, should never be arrived at
            print("AppDelegate if/else sequence failed, defaulting to initialize")
            initialViewController = storyboard.instantiateViewController(withIdentifier: "Initial Profile VC")
        }
        
        self.window?.rootViewController = initialViewController
        
        self.window?.makeKeyAndVisible()
        
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
        if Globals.globals.initialized {
            Person.encodeEveryone()
        }
    }
    
    func recoverOldData() -> Bool {
        if let temp = Person.decodePeople() {
            if temp.count < 1 {return false}
            Globals.globals.teamRoster = temp
            print(Globals.globals.teamRoster[0])
            Globals.globals.user = Globals.globals.teamRoster[0]
            return true
        }
        else {
            print("recover old data failed as fuck")
            Globals.globals.teamRoster[0] = Person()
            Globals.globals.user = Globals.globals.teamRoster[0]
            return false
        }
    }
}

