//
//  TabBarView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 2/15/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class TabBarView: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        
    }
    
    
    
    
    
    
    @available(iOS 3.0, *)
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        
        return true
    }
    
    @available(iOS 2.0, *)
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        
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
