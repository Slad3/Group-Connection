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
    
    var firstName: String //essential
    var lastName: String //essential
    var isMentor: Bool //essential
    var age: Int //essential
    var phoneNumber: String //essential
    var email: String //essential
    var subteam: String //essential
    var additionalNotes: String //essential
    var fullName: String!
    
    var peerid: MCPeerID! //essential
    
    //mentor-specific stuff
    var hasCheckIn: Bool! //the mentor has a check waiting
    var checkArray: [Check]! //where the checks get held
    
    init() {
        firstName = ""
        lastName = ""
        isMentor = false
        age = -1
        phoneNumber = ""
        email = ""
        subteam = ""
        additionalNotes = ""
        peerid = nil
        
        print("I hope you didn't use the default init, you jackass")
    }
    
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
    
    func getValues() -> (String, String, Bool, Int, String, String, String, String, String) {
        return (firstName, lastName, isMentor, age, phoneNumber, email, subteam, peerid.displayName, additionalNotes)
    }
}

