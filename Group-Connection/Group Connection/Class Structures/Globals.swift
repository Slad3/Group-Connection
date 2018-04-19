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
    //public var session: MCSession!
    var user: Person!
    var hans: Person
    var event: Event!
    var teamRoster: [Person]
    var selectedIndex: Int!
    var notificationCentre = NotificationCenter.default
    var passingData: (String, String, String, String, String )
    var isCreator = false
    
    var visitedRoster: Bool = false
        
    var manager: Manager!
    
    
    init() {
        initialized = false
        inEvent = false
        isMentor = false
        hans = Person(firstName: "colonel hans", lastName: "landa", isMentor: false, age: 37, email: "myPipeIsBiggerThanYours@aol.com", phoneNumber: "9493781933", additionalNotes: "bwahahaha", ssubteam: "the jew hunter")
        hans.checkInStatus = true
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
    
    func setPeerid(fullname: String){
        
        let peerid = MCPeerID(displayName: fullname)
        
    }
    
    func autopopulateRoster() {
        let upperbound = Int(arc4random_uniform(50))
        teamRoster.reserveCapacity(upperbound)
        for _ in 0...upperbound {
            teamRoster.append(Person.reachedFortyAndIsDesperate())
            
        }
        return
    }
    
    func autopopulate(_ persons: [Person]) -> [Person]{
        let upperbound = 3
        var peeps = persons
        
        peeps.reserveCapacity(upperbound)
        
        for _ in 0...upperbound {
            peeps.append(Person.reachedFortyAndIsDesperate())
        }
        
        return peeps
    }
    
    static func getIDs(_ peeps: [Person]) -> [MCPeerID] {
        var temp: [MCPeerID] = []
        for dude in peeps {
            //temp.append(dude.peerid)
        }
        return temp
    }
}

