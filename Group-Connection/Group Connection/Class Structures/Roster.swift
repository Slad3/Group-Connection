//
//  Roster.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 1/29/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import os.log
import MultipeerConnectivity

class Roster: NSObject, NSCoding {

    var stringNames: [String]
    var fileStoredName: String
    
    struct Properties { //strings to find the data after encoding
        static let stringNames = "stringNames"
        static let fileStoredName = "fileStoredName"
    }
    
    var DocumentsDirectory: URL
    var ArchiveURL: URL
    
    
    init?(names: [Person], fileName: String) {
        guard !names.isEmpty else {
            return nil
        }
        
        stringNames = Roster.toStrings(people: names)
        fileStoredName = fileName
        DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        ArchiveURL = DocumentsDirectory.appendingPathComponent(fileName)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stringNames, forKey: Properties.stringNames)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let temp = aDecoder.decodeObject(forKey: Properties.stringNames) as? [String] else {
            os_log("Unable to decode stuff.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(names: Roster.toPerson(strs: temp), fileName: Properties.fileStoredName)
    }
    
    func archiveString(str: [Person]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(stringNames, toFile: ArchiveURL.path)
        if isSuccessfulSave {
            os_log("String successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save String...", log: OSLog.default, type: .error)
        }
    }
    
    func restoreString() -> [Person]  {
        let tmp = NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [String]
        return Roster.toPerson(strs: tmp!)
    }
    
    static func toStrings(people: [Person]) -> [String] {
        var things: (firstName: String, lastName: String, isMentor: Bool, age: Int, phoneNumber: String, email: String, subteam: String, peerid: String, additionalNotes: String)
        var out: [String] = [] //1D array, one for each Manzana
        for person in people {
            things = person.getValues()
            out.append("""
                \(things.firstName),\(things.lastName),\(things.isMentor),\(things.age),\(things.phoneNumber),\(things.email),\(things.subteam),\(things.peerid),\(things.additionalNotes);
                """)
        }
        return out
    }
    
    static func toPerson(strs: [String]) -> [Person] {
        var out: [Person]! = [] //1D array, one for each line
        
        for str in strs {
            var temp = str
            let apple = Person()
            
            var ind =  temp.index(of: ",")
            var range = temp.startIndex..<ind
            apple.firstName = temp.substring(with: range)
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ",")
            range = temp.startIndex..<ind
            apple.lastName = temp.substring(with: range)
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ",")
            range = temp.startIndex..<ind
            apple.isMentor = Roster.toBool(str: temp.substring(with: range))
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ",")
            range = temp.startIndex..<ind
            apple.age = Int(temp.substring(with: range))!
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ",")
            range = temp.startIndex..<ind
            apple.phoneNumber = temp.substring(with: range)
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ",")
            range = temp.startIndex..<ind
            apple.email = temp.substring(with: range)
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ",")
            range = temp.startIndex..<ind
            apple.subteam = temp.substring(with: range)
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ",")
            range = temp.startIndex..<ind
            apple.peerid = MCPeerID(displayName: temp.substring(with: range))
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the comma
            
            ind =  temp.index(of: ";")
            range = temp.startIndex..<ind
            apple.additionalNotes = temp.substring(with: range)
            temp.removeSubrange(range)
            temp.remove(at: temp.startIndex) //remove the semicolon
            
            out.append(apple)
        }
        return out
    }
    
    static func toBool(str: String) -> Bool {
        if str == "true" {return true}
        return false
    }
    
    
}


