//
//  Event.swift
//
//
//  Created by Daniel e. Naranjo Sampson on 12/15/17.
//
import Foundation
import UIKit
import MultipeerConnectivity
class Event {
    //properties
    var generalAccessCode: String //access code to hook people up to the right compeititon
    var mentorAccessCode: String //access code to verify status as a mentor
    var importedMap: UIImage! //swift catch-all for images of any data type; optional type for right now (UIImages have to get an actual image for them when they're initialized
    var competitionRoster: [Person] //list of all the users in the competion
    var teamRoster: [String] //list of all the people in the team
    var peeridRoster: [MCPeerID] //list of all the peer ids on the team
    var mentorRoster: [Person] = []//List of all mentors in roster
    var creator: Person //Creator of the event
    var eventName: String
    var checkInLength: Double //minutes until required check-in
    var timeTillNotification: Double //minutes in between reminders to check in
    var groupName: String //Name of the Group
    
    //init
    init(user: Person) {
        generalAccessCode = ""
        mentorAccessCode = ""
        
        importedMap = nil
        competitionRoster = []
        competitionRoster.append(user)
        teamRoster = []
        peeridRoster = []
        mentorRoster.append(user)
        teamRoster.append(user.firstName)
        
        eventName = ""
        checkInLength = -1.0
        timeTillNotification = -1.0
        groupName = ""
        creator = user
        return
    }
    
    struct evant {
        
        
        
        
    }
    
    //Generates random string of 3 words
    static func makeCode() -> String {
        var str = Lorem.words(2)
        /*var pop = str.index(str.startIndex, offsetBy: 8)
        str.remove(at: pop)
        pop = str.index(str.startIndex, offsetBy: 16)
        str.remove(at: pop)
        print("makeCode() gave us " + str)*/
        //Make the String 10 charactors
        
        if(str.count > 10){
            let rangeOne = str.index(str.startIndex, offsetBy: 0)
            let rangeTwo = str.index(str.startIndex, offsetBy: 10)
            let stringRange = Range(uncheckedBounds: (lower: rangeOne, upper: rangeTwo))
            str = str.replacingCharacters(in: stringRange, with: str)
            //str = str.prefix(upTo: index) // Hello
        }
        
        
        print("Refined makeCode() gave us " + str)
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
    
    func matchUpPeerIds(){
        //set function to re order the array to the peerid array
        
    }
}
