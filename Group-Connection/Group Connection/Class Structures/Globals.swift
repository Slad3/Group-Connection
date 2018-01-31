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
    let hans = Person(ffirstName: "colonel hans", llastName: "landa", iisMentor: false, aage: 37, eemail: "myPipeIsBiggerThanYours@aol.com", aaditionalNotes: "bwahahaha", ssubteam: "the jew hunter")

    var teamRoster: [Person]!
    
    init() {
        initialized = false
        inEvent = false
        isMentor = false
        teamRoster = [hans]
    }
}
