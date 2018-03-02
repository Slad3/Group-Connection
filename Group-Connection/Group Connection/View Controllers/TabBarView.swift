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

class TabBarView: UITabBarController, UITabBarControllerDelegate {
    
    //var currentView: UIViewController!
    var advertisementAssistant: MCAdvertiserAssistant!
    
    
    
    override func viewDidLoad() {
        print("Using custom tab bar view controller")
        //currentView = CreateEventView()
        
        if(Globals.globals.isCreator){
            advertisementAssistant = MCAdvertiserAssistant(serviceType: Globals.globals.passingData.0, discoveryInfo: ["Group Name": Globals.globals.passingData.1, "Event Name": Globals.globals.passingData.2, "Full Name": Globals.globals.passingData.3, "Discription": Globals.globals.passingData.4 ], session: Globals.globals.session)
        //advertisementAssistant = MCAdvertiserAssistant(serviceType: accessCodeThing, discoveryInfo: nil, session: Globals.globals.Session)
        advertisementAssistant.start()
        print("Advertising Started")
    }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //storyboard?.instantiateViewController(withIdentifier: currentView.title!)
    }
    
    public func toSpecificTab (viewController: UIViewController){
        
        print(viewController.title)
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
