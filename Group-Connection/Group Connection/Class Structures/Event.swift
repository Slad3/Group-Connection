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
    var competitionRoster: [Person] //list of all the users in the competion
    var teamRoster: [String] //list of all the people in the team
    var eventName: String
    var checkInLength: Double //minutes until required check-in
    var timeTillNotification: Double //minutes in between reminders to check in
    
    //init
    init(user: Person) {
        
        generalAccessCode = ""
        mentorAccessCode = ""
        
        importedMap = nil
        competitionRoster = []
        competitionRoster.append(user)
        teamRoster = []
        teamRoster.append(user.firstName)
        
        eventName = ""
        checkInLength = -1.0
        timeTillNotification = -1.0
        return
    }
    
    //Generates random string of 3 words
    static func makeCode() -> String {
        let str = Lorem.words(3)
        return str
    }
    
    //Never call if general code isn't initialized
    func isGeneralAccessCode(inputCode: String) -> Bool {
        return (inputCode == generalAccessCode)
    }
    
    //Never call if mentor code isn't initialized
    func isMentorAccessCode(inputCode: String) -> Bool {
        return (inputCode == mentorAccessCode)
    }
}
