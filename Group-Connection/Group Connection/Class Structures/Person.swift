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
    var profilePhoto: UIImage!
    
    //mentor-specific stuff
    var hasCheckIn: Bool! //the mentor has a check waiting
    var checkArray: [Check]! //where the checks get held
    
    //encoding stuff
    static var jsonDerulo: Data!
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("people")
    
    struct Persoon: Codable {
        let firstName: String //essential
        let lastName: String //essential
        let isMentor: Bool //essential
        let age: Int //essential
        let phoneNumber: String //essential
        let email: String //essential
        let subteam: String //essential
        let additionalNotes: String //essential
        let hasCheckIn: Bool //the mentor has a check waiting
        //var checkArray: [Check]!
        
        init(person: Person){
            self.firstName = person.firstName
            self.lastName = person.lastName
            self.isMentor = person.isMentor
            self.age = person.age
            self.phoneNumber = person.phoneNumber
            self.email = person.email
            self.subteam = person.subteam
            self.additionalNotes = person.additionalNotes
            self.hasCheckIn = person.hasCheckIn ?? false
        }
        
        func toPerson() -> Person {
            return Person(firstName: self.firstName, lastName: self.lastName, isMentor: self.isMentor, age: self.age, email: self.email, phoneNumber: self.phoneNumber, additionalNotes: self.additionalNotes, ssubteam: self.subteam)
        }
    }
    
    struct Roster: Codable, Sequence {
        let people: [Persoon]
        
        func makeIterator() -> VoodooMagic {
            return VoodooMagic(people: people)
        }
        
        func makePeople() -> [Person] {
            var temp: [Person] = []
            for dude in people {
                temp.append(dude.toPerson())
            }
            return temp
        }
    }
    
    struct VoodooMagic: IteratorProtocol {
        let people: [Persoon]
        var current = 0
        
        init(people: [Persoon]) {
            self.people = people
        }
        
        mutating func next() -> Persoon? {
            defer {current += 1}
            return people.count > current ? people[current] : nil
        }
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
    
    static func encodeEveryone(){
        print("encoding people")
        let people: [Person] = Globals.globals.teamRoster
        var peoples: [Person.Persoon] = []
        
        for person in people {
            peoples.append(Persoon(person: person))
            print(person)
        }
        
        let roster = Person.Roster(people: peoples)
        
        do {
            jsonDerulo = try JSONEncoder().encode(roster)
            try jsonDerulo.write(to: ArchiveURL)
            print(ArchiveURL)
            print(String(data: jsonDerulo, encoding: .utf8) ?? "didn't work bud")
        }
        catch {
            print("It didn't work and it's clearly all Nick's fault. Blame him.")
        }
    }
    
    static func decodePeople() -> [Person]?  {
        do {
            jsonDerulo = try Data(contentsOf: ArchiveURL)
            let roster = try JSONDecoder().decode(Roster.self, from: jsonDerulo)
            print(String(data: jsonDerulo, encoding: .utf8)!)
            return roster.makePeople()
        }
        catch {
            print("decoding failed")
            return nil
        }
    }
}

