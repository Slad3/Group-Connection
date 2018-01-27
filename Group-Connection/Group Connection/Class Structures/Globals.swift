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
    static let globals: Globals! = Globals()
    var initialized, inEvent: Bool
    var isMentor: Bool
    var user: Person!
    let hans = Person(ffirstName: "hans", llastName: "landa", iisMentor: false, aage: 15, eemail: "none", aaditionalNotes: "none", ssubteam: "none")

    var teamRoster: [Person]!
    
    
    
    init() {
        initialized = false
        inEvent = false
        isMentor = false
        teamRoster = [hans]
        
    }
       
    
    
    
    
    
    
}
