//
//  Person.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Person {
    
    var firstName: String
    var lastName: String
    var isMentor: Bool
    var age: Int
    var phoneNumber: String
    var email: String
    var subteam: String
    var additionalNotes: String
    var fullName: String
    var peerid: MCPeerID!
    
    //mentor-specific stuff
    var hasCheckIn: Bool! //the mentor has a check waiting
    var checkArray: [Check]! //where the checks get held
    
    //    var isCreator: Bool? //optional so we can hold off initialization until later

    init(ffirstName: String, llastName: String, iisMentor: Bool, aage: Int, eemail: String, aaditionalNotes: String, ssubteam: String) {
        
        //Required Initialized Variables
        self.firstName = ffirstName
        self.lastName = llastName
        self.isMentor = iisMentor
        self.age = aage
        self.email = eemail
        self.additionalNotes = aaditionalNotes
        self.subteam = ssubteam
        self.fullName = self.firstName + " " + self.lastName
        self.phoneNumber = ""
        self.checkArray = []
        self.peerid = MCPeerID(displayName: fullName)
        return
    }
    //Second initializer for when there is a phone number input
    init(firstName: String, lastName: String, isMentor: Bool, age: Int, email: String, phoneNumber: String, additionalNotes: String, ssubteam: String ) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.isMentor = isMentor
        self.age = age
        self.email = email
        self.additionalNotes = additionalNotes
        self.phoneNumber = phoneNumber
        self.subteam = ssubteam
        self.fullName = self.firstName + " " + self.lastName
        
        self.checkArray = []
        self.peerid = MCPeerID(displayName: fullName)
        return
        
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    func addCheck(check: Check) {
        self.checkArray?.append(check)
        return
    }
    
    
    
    
}

