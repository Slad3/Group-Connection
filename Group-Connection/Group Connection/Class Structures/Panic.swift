//
//  Panic.swift
//  Group Connection
//
//  Created by Ben on 4/27/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import MapKit

class Panic: NSObject, MKAnnotation{
    var sender: Person
    var coordinate: CLLocationCoordinate2D
    var timeSent: Date

    struct penac: Codable{
        var sender: Person.Persoon
        var latitude: Double
        var longitude: Double
        var timeSent: String

        init(_ panic: Panic){
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            formatter.locale = Locale(identifier: "en_US")
            
            timeSent = formatter.string(from: panic.timeSent)
            
            sender = Person.Persoon(panic.sender)
            
            latitude = panic.coordinate.latitude
            longitude = panic.coordinate.longitude
        }
    }



    init(dude: Person, sentCoordinate: CLLocationCoordinate2D){
        sender = dude
        coordinate = sentCoordinate
        timeSent = Date()
    }
    
    override init(){
        sender = Globals.globals.user
        coordinate = CLLocationCoordinate2D.init()
        timeSent = Date()
        
    }

    init(_ penac: Panic.penac) {
        self.sender = penac.sender.toPerson()
        self.coordinate = CLLocationCoordinate2D(latitude: penac.latitude, longitude: penac.longitude)
        
        let formatter = DateFormatter()
        self.timeSent = formatter.date(from: penac.timeSent)!
    }
}

