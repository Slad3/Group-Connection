//
//  Event.swift
//  
//
//  Created by Daniel e. Naranjo Sampson on 12/15/17.
//

import Foundation
import UIKit

class Event {
    //properties
    var generalAccessCode: String //access code to hook people up to the right compeititon
    var mentorAccessCode: String //access code to verify status as a mentor
    var importedMap: UIImage? //swift catch-all for images of any data type; optional type for right now (UIImages have to get an actual image for them when they're initialized
//    var competitionRoster: [People] //list of all the users in the competion
    var teamRoster: [String] //list of all the people in the team
    var eventName: String
    var checkInLength: Double //minutes until required check-in
    var timeTillNotification: Double //minutes in between reminders to check in
    
    //init
    init(/*this person*/) {
        generalAccessCode = ""
        mentorAccessCode = ""
        
        importedMap = nil
//        competitionRoster = []
//        competitionRosteer.append(/*this person*/)
        teamRoster = []
        teamRoster.append(/*this person's name*/)
        eventName = ""
        checkInLength = -1.0
        timeTillNotification = -1.0
        return 
    }
    
    static func makeCode() -> String {
        //make random 3 word strings for general and mentor access codes
        let lorem = Lorem
        let str = lorem.words(3)
        return str 
    }
    
}
