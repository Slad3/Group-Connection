//
//  Globals.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 12/13/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation

class Globals {
    static let globals: Globals! = Globals()
    
    var initialized, inEvent: Bool
    var isMentor: Bool
    var hasStoredData = UserDefaults.standard.bool(forKey: "hasStoredData")
    var user: Person!
    let hans = Person(firstName: "colonel hans", lastName: "landa", isMentor: false, age: 37, email: "myPipeIsBiggerThanYours@aol.com", phoneNumber: "9493781933", additionalNotes: "bwahahaha", ssubteam: "the jew hunter")

    var teamRoster: [Person]!
    
    init() {
        initialized = false
        inEvent = false
        isMentor = false
        teamRoster = [hans]
    }
}
