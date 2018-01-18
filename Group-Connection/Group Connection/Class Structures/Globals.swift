//
//  Globals.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 12/13/17.
//  Copyright © 2017 District196. All rights reserved.
//
/*  Complete and total stub; fields in here need to be alterable from other classes or straight up in other classes.
*/
import Foundation

class Globals {
    var initialized, inEvent: Bool
    var isMentor: Bool
    public var user: Person!
    public let hans = Person(ffirstName: "hans", llastName: "landa", iisMentor: false, aage: 15, eemail: "none", aaditionalNotes: "none", ssubteam: "none")
    public var teamRoster: [Person]!
    
    
    
    
    
    init() {
        teamRoster = [hans]
        initialized = false
        inEvent = false
        isMentor = false
        

        
    }
       
    
    
    
    
    
    
}

