//
//  Globals.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 12/13/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import MultipeerConnectivity

class Globals {
    
    static let globals: Globals! = Globals()
    
    var initialized, inEvent: Bool
    var isMentor: Bool
    var hasStoredData = UserDefaults.standard.bool(forKey: "hasStoredData")
    public var session: MCSession!
    var user: Person!
    let hans = Person(firstName: "colonel hans", lastName: "landa", isMentor: false, age: 37, email: "myPipeIsBiggerThanYours@aol.com", phoneNumber: "9493781933", additionalNotes: "bwahahaha", ssubteam: "the jew hunter")
    var event: Event!
    var teamRoster: [Person]
    var selectedIndex: Int!
    var notificationCentre = NotificationCenter.default
    var passingData: (String, String, String, String, String )
    var isCreator = false
    
    init() {
        initialized = false
        inEvent = false
        isMentor = false
        teamRoster = [hans]
        passingData = ("", "", "", "", "")
    }
    
    func getStudents() -> [Person] {
        var temp: [Person] = []
        for dude in teamRoster {
            if !dude.isMentor {
                temp.append(dude)
            }
        }
        return temp
    }
    
    func getMentors() -> [Person] {
        var temp: [Person] = []
        for dude in teamRoster {
            if dude.isMentor {
                temp.append(dude)
            }
        }
        return temp
    }
    
    func findPerson(full name: String) -> Person! {
        for i in teamRoster {
            if i.fullName == name {
                return i
            }
        }
        return nil
    }
    
    func autopopulateRoster() {
        let upperbound = Int(arc4random_uniform(50))
        teamRoster.reserveCapacity(upperbound)
        for _ in 0...upperbound {
            teamRoster.append(Person.reachedFortyAndIsDesperate())
        }
        return
    }
    
    static func getIDs(_ peeps: [Person]) -> [MCPeerID] {
        var temp: [MCPeerID] = []
        for dude in peeps {
            temp.append(dude.peerid)
        }
        return temp
    }
}

