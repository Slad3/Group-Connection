//
//  TabBarView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 2/15/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity
import MapKit

class TabBarView: UITabBarController, UITabBarControllerDelegate {
    
    //var currentView: UIViewController!
    
    var advertisementAssistant: MCAdvertiserAssistant!
    
    
    override func viewDidLoad() {
        print("Using custom tab bar view controller")
        print(Globals.globals.manager.peerid.displayName)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vcs: [UIViewController]
        
        let map = storyboard.instantiateViewController(withIdentifier: "Map")
        let roster = storyboard.instantiateViewController(withIdentifier: "Roster")
        let profile = storyboard.instantiateViewController(withIdentifier: "ProfileView")
        
        if Globals.globals.user.isMentor {
            let mentor = storyboard.instantiateViewController(withIdentifier: "Mentor")
            
            vcs = [mentor, map, roster, profile]
            
        }
        else {
            let student = storyboard.instantiateViewController(withIdentifier: "Check In")
            vcs = [student, map, roster, profile]
        }
        
        self.viewControllers = vcs.map { UINavigationController(rootViewController: $0)}
        
        if Globals.globals.isCreator {
            
            //Globals.globals.manager.setupAdvertising(accessCode: Globals.globals.passingData.0)
            
            
            print("Is Creator")
            var service = false
            
            if (service){
                let serviceBrowser = MCNearbyServiceBrowser(peer: Globals.globals.manager.peerid, serviceType: Globals.globals.passingData.0)
                serviceBrowser.delegate = Globals.globals.manager
                print("Access Code: " + Globals.globals.passingData.0)
                serviceBrowser.startBrowsingForPeers()
                print("Advertising Started")
                
            }
            else {
                
                Globals.globals.manager.advertisementHandler(code: Globals.globals.passingData.0)
                
            }
        }
        
        //delete everything below this if I haven't already
        let lugar = CLLocation(latitude: 44.821152, longitude: -93.120435)
        let check = Check(sender: Globals.globals.hans, place: lugar, description: "ta da!")
        Check.receiveCheck(check: check)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //storyboard?.instantiateViewController(withIdentifier: currentView.title!)
    }
    
    public func toSpecificTab (viewController: UIViewController){
        
        print(String(describing: viewController.title))
        storyboard?.instantiateViewController(withIdentifier: "Main Tab VC")
        storyboard?.instantiateViewController(withIdentifier: viewController.title!)
        
    }
    
    
    
    
    @available(iOS 3.0, *)
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        //currentView = viewController
        //print(currentView.title!)
        storyboard?.instantiateViewController(withIdentifier: viewController.title!)
        return true
    }
    
    @available(iOS 2.0, *)
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        //currentView = viewController
        //print("did select" + currentView.title!)
        storyboard?.instantiateViewController(withIdentifier: viewController.title!)
        
        
    }
    
    
    @available(iOS 3.0, *)
    public func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]){
        
        
    }
    
    @available(iOS 3.0, *)
    public func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool){
        
        
    }
    
    @available(iOS 2.0, *)
    public func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool){
        
        
    }
    
    
}

