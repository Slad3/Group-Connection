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
    var checkInStatus: Bool //essential
    var peerid: MCPeerID! //essential
    
    //mentor-specific stuff
    var hasCheckIn: Bool! //the mentor has a check waiting
    var checkArray: [Check]! //where the checks get held

    //
    static var jsonData: Data!
    static var json: Any?
    
    struct Persoon: Codable {
        var firstName: String //essential
        var lastName: String //essential
        var isMentor: Bool //essential
        var age: Int //essential
        var phoneNumber: String //essential
        var email: String //essential
        var subteam: String //essential
        var additionalNotes: String //essential
        var hasCheckIn: Bool //the mentor has a check waiting
        //var checkArray: [Check]!
    }
    
    struct Roster: Codable {
        var people: [Persoon]
    }
    
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
        checkInStatus = false
        print("I hope you didn't use the default init, you jackass")
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
        self.checkInStatus = false
        return
    }
    
    func addCheck(check: Check) {
        self.checkArray?.append(check)
        return
    }
    
    func getValues() -> (String, String, Bool, Int, String, String, String, String, String) {
        return (firstName, lastName, isMentor, age, phoneNumber, email, subteam, peerid.displayName, additionalNotes)
    }
    
    static func encodePerson(john: Person) {
        let first = john.firstName
        let last = john.lastName
        let isMentor = john.isMentor
        let age = john.age
        let phone = john.phoneNumber
        let email = john.email
        let subteam = john.subteam
        let add = john.additionalNotes
        let hasCheck = john.hasCheckIn
        
        if let dave: Person.Persoon = Person.Persoon(firstName: first, lastName: last, isMentor: isMentor, age: age, phoneNumber: phone, email: email, subteam: subteam, additionalNotes: add, hasCheckIn: hasCheck ?? false) {
            print("\(dave)")
            jsonData = try? JSONEncoder().encode(dave)
            print(String(data: jsonData, encoding: .utf8) ?? "didn't work bud")
        }
        else {
            print("NOOOOPE SHIT AIN'T WORK MAH CHILD")
        }
    }
    
//    static func decodePeople() -> [Person]?  {
//        for _ in Globals.globals.teamRoster {
//            
//        }
//        if let dave = try? JSONDecoder().decode(Person.Persoon.self, from: jsonData){
//            let john = Person(firstName: dave.firstName, lastName: dave.lastName, isMentor: dave.isMentor, age: dave.age, email: dave.email, phoneNumber: dave.phoneNumber, additionalNotes: dave.additionalNotes, ssubteam: dave.subteam)
//            return john
//        }
//        else {
//            return nil
//        }
//    }
}

