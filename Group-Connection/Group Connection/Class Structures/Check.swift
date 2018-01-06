//
//  Check.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 1/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import MapKit

class Check: NSObject, MKAnnotation {
    var sender: Person
    var coordinate: CLLocationCoordinate2D //sender's location. named coordinate because of interface stuff
    var title: String? //also interface stuff
    var subtitle: String? //interface stuff
    var senderDescription: String
    var timeSent: Date
    
    var hasBeenSent: Bool
    
    init(sender: Person, place: CLLocation, description: String) {
        let location = place.coordinate
       
        self.sender = sender
        self.coordinate = location
        self.senderDescription = description
        self.timeSent = Date()
        self.title = sender.firstName
        self.subtitle = senderDescription
        self.hasBeenSent = false
    }
    
    func sendThisCheck() {
        //fill in once we've gotten the connectivity stuff figured out
        //has to somehow trigger receiveCheck() on the receiver's phone
        self.hasBeenSent = true
    }
    
    static func receiveCheck(check: Check) {
        globals.user?.hasCheckIn = true
        globals.user?.addCheck(check: check)
    }
}
