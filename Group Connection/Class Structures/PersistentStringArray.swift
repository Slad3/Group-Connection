//
//  PersistentStringArray.swift
//  ScrollTest
//
//  Created by behnke on 6/24/17.
//  Copyright © 2017 George K Behnke. All rights reserved.
//

import Foundation
import os.log

// 2
class PersistentStringArray: NSObject, NSCoding {
    
    var stringNames: [String]
    var fileStoredName: String
    
    // 1
    // create structure to link object's Properties to variable names to archive
    struct PropertyKey {   // String values are same name as Properties they name
        static let stringNames = "stringNames"
        static let fileStoredName = "fileStoredName"
    }
    
    // 3
    // This creates a path to the ArchiveURL & its file's Directory
    var DocumentsDirectory: URL
    var ArchiveURL: URL
    
    //  Create the instance of the String to archive to long term storage
    //  This is the usual initializer for the class.
    init?(names: [String], fileName: String) { //  names: the String array to archive; fileName: the name of the file in which to store the archive

        guard !names.isEmpty else {
            return nil
        }
        
        // Initialize properties.
        stringNames = names
        fileStoredName = fileName
        DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        ArchiveURL = DocumentsDirectory.appendingPathComponent(fileName)
    }
    
    // 2a
    // Attach the property names to the archived names
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stringNames, forKey: PropertyKey.stringNames)
    }
    
    // 2b
    // create the instance with the archive information
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required
        guard let names = aDecoder.decodeObject(forKey: PropertyKey.stringNames) as? [String] else {
            os_log("Unable to decode the name for a PersistenStringArray object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(names: names, fileName: PropertyKey.fileStoredName)
    }
    
    
    
    
    // 4a
    // Saves String information to long term storage
    func archiveString(str: [String]) { //  str: the String to be archived
        stringNames = str
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(stringNames, toFile: ArchiveURL.path)
        if isSuccessfulSave {
            os_log("String successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save String...", log: OSLog.default, type: .error)
        }
    }
    
    // 4b
    // Read (Restore) archived String information from storage
    // Returns nil if the String has not yet been archived to the file
    func restoreString() -> [String]?  {
        let tmp = NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [String]
        return tmp
    }
}

