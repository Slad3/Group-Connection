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
    
    override init() {
        print("I hope you didn't use the default init you jackass")
        sender = Globals.globals.hans
        coordinate = CLLocationCoordinate2D()
        senderDescription = ""
        timeSent = Date()
        hasBeenSent = false
    }
    
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
    
    func sendThisCheck( to: Person) {
        //fill in once we've gotten the connectivity stuff figured out
        //has to somehow trigger receiveCheck() on the receiver's phone
    
        print("sending check")
        do {
            let temp = try JSONEncoder().encode("receiveCheck")
            try Globals.globals.manager.session.send(temp, toPeers: [], with: .reliable)
            self.hasBeenSent = true
            print("sent")
        }
        catch {
            print("failed")
        }
    }
    
    static func receiveCheck(check: Check) {
        Globals.globals.user?.hasCheckIn = true
        Globals.globals.user?.addCheck(check: check)
        print("Check \(check.sender.firstName) received")
    }
}

