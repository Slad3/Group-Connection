//
//  Check.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/15/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation

class Check{
    
    var identity: Person
    
    var locationGPS: String  //Will be changed to location object later
    
    var locationPlace: String
    
    var timeImplemented: String   // Will be changed to Time
    
    var status: String
    
    var timeSinceLastCheckIn: String
    
    var checkInLength: Double
    
    var timeUntilNotification: Double
    
    
    
    
    
    
    init(iidentity: Person, ccheckInLength: Double, llocationGPS: String, llocationPlace: String, ttimeImplemented: String, sstatus: String, ttimeSinceLastCheckIn: String, ttimeUntilNotification: Double){
        
        
        self.identity = iidentity
        self.locationGPS = llocationGPS
        self.locationPlace = llocationPlace
        self.status = sstatus
        self.timeSinceLastCheckIn = ttimeSinceLastCheckIn
        self.timeUntilNotification = ttimeUntilNotification
        
        self.timeImplemented = ttimeImplemented
        
        self.checkInLength = ccheckInLength
        
        
        
        
    }
    
    
    
    
}

