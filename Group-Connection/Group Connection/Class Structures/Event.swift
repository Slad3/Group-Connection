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

    init(_ event: evant) {
        generalAccessCode = event.generalAccessCode
        importedMap = UIImage(data: event.importedMap)
        competitionRoster = event.competitionRoster.makePeople()
        teamRoster = event.teamRoster
        mentorRoster = event.mentorRoster.makePeople()
        creator = event.creator.toPerson()
        eventName = event.eventName
        checkInLength = event.checkInLength
        timeTillNotification = event.timeTillNotification
        groupName = event.groupName
        peeridRoster = []
        
        return
    }
    
    struct evant: Codable {
        
        var generalAccessCode: String //access code to hook people up to the right compeititon
        
        var importedMap: Data! //swift catch-all for images of any data type; optional type for right now (UIImages have to get an actual image for them when they're initialized
        var competitionRoster: Person.Roster //list of all the users in the competion
        var teamRoster: [String] //list of all the people in the team
        var mentorRoster: Person.Roster//List of all mentors in roster
        var creator: Person.Persoon //Creator of the event
        var eventName: String
        var checkInLength: Double //minutes until required check-in
        var timeTillNotification: Double //minutes in between reminders to check in
        var groupName: String //Name of the Group
        
        init(_ evint: Event){
            
            generalAccessCode = evint.generalAccessCode //access code to hook people up to the right compeititon
            if(evint.importedMap != nil){
                importedMap = UIImagePNGRepresentation(evint.importedMap)
            }
            else{
                importedMap = UIImagePNGRepresentation(UIImage(named: "download (1)")!)
            }
            //swift catch-all for images of any data type; optional type for right now (UIImages have to get an actual image for them when they're initialized
            
            var temp: [Person.Persoon] = []
            for i in evint.competitionRoster {
                temp.append(Person.Persoon(i))
            }
            competitionRoster = Person.Roster(people: temp) //list of all the users in the competion
            
            teamRoster = evint.teamRoster//list of all the people in the team
            
            temp = []
            for i in evint.mentorRoster {
                temp.append(Person.Persoon(i))
            }
            mentorRoster = Person.Roster(people: temp) //List of all mentors in roster
            creator = Person.Persoon(evint.creator)//Creator of the event
            eventName = evint.eventName
            checkInLength = evint.checkInLength//minutes until required check-in
            timeTillNotification = evint.timeTillNotification //minutes in between reminders to check in
            groupName = evint.groupName //Name of the Group
            
        }
        
        
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
    
    
    //Find Person Stuff
    func findPerson(name: String) -> Person {
        
        for nam in Globals.globals.event.competitionRoster {
            if (name == nam.fullName){
                return nam
            }
            
        }
        return Globals.globals.user
        
    }
    
    func findPeerIDs(names: [String]) -> [Person]{
        
        var list: [Person] = []
        
        for na in names{
            list.append(findPerson(name: na))
        }
        return list
    }
    
    //Find Peer ID Stuff
    func findPeerID(name: String) -> MCPeerID {
        
        for nam in Globals.globals.manager.session.connectedPeers {
            if (name == nam.displayName){
                return nam
            }
   
        }
        return Globals.globals.manager.peerid
  
    }
    
    
    
    func findPeerIDs(names: [String]) -> [MCPeerID]{
    
        var list: [MCPeerID] = []
        
        for na in names{
            list.append(findPeerID(name: na))
        }
        return list
    }
}
