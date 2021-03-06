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
    
    struct Xeck : Codable {
        var sender: Person.Persoon
        var latitude: Double //sender's location. named coordinate because of interface stuff
        var longitude: Double
        var title: String? //also interface stuff
        var subtitle: String? //interface stuff
        var senderDescription: String
        var timeSent: String
        
        init(_ check: Check) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            formatter.locale = Locale(identifier: "en_US")
            timeSent = formatter.string(from: check.timeSent)
            
            latitude = check.coordinate.latitude
            longitude = check.coordinate.longitude
            
            title = check.title
            subtitle = check.subtitle
            senderDescription = check.senderDescription
            
            sender = Person.Persoon(check.sender)
        }
    }
    
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
    
    init(_ check: Xeck) {
        print(check.timeSent)
        var formatter = DateFormatter()
        self.timeSent = formatter.date(from: check.timeSent) ?? Date()
        print(self.timeSent.debugDescription)
        print(check.timeSent)
        
        coordinate = CLLocationCoordinate2D(latitude: check.latitude, longitude: check.longitude)
        sender = check.sender.toPerson()
        senderDescription = check.senderDescription
        title = check.title
        subtitle = check.subtitle
        
        hasBeenSent = true //true because this check is being recreated after being sent
    }
    
    func sendThisCheck( to: Person) {
        //fill in once we've gotten the connectivity stuff figured out
        //has to somehow trigger receiveCheck() on the receiver's phone
        
        print("sending check")
        do {
            let temp = Present(ident: "check", theCheck: self)
            try Globals.sendData(message: temp, toPeers: Globals.globals.event.mentorRoster)
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
 
 
