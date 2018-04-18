//
//  Check.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 1/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import MapKit
import MultipeerConnectivity

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
    
    override init(){
        self.sender = Person()
        //self.coordinate  = CLLocation(latitude: 44.821152, longitude: -93.120435)
        self.coordinate = CLLocationCoordinate2D(latitude: 23, longitude: 34)
        self.senderDescription = ""
        self.timeSent = Date()
        self.title = ""
        self.subtitle = ""
        self.hasBeenSent = false
        
    }
    
    func sendThisCheck(_ person: Person) {
        //fill in once we've gotten the connectivity stuff figured out
        //has to somehow trigger receiveCheck() on the receiver's phone
        do {
            let temp = try JSONEncoder().encode("receiveCheck")
            try Globals.globals.manager.session.send(temp, toPeers: [], with: .reliable)
            self.hasBeenSent = true
        }
        catch {
            print("sending check failed")
        }
    }
    
    static func receiveCheck(check: Check) {
        Globals.globals.user?.hasCheckIn = true
        Globals.globals.user?.addCheck(check: check)
        print("Check \(check.sender.firstName) received")
    }
}

