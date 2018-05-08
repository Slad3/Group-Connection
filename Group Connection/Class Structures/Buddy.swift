//
//  Person.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation

class Buddy {
    
    var firstName: String
    
    var lastName: String
    
    
    var age: Int
    
    var phoneNumber: String
    
    var email: String
    
    var additionalNotes: String

    
    init(ffirstName: String, llastName: String, aage: Int, eemail: String, aaditionalNotes: String) {
        //Required Initialized Variables
        self.firstName = ffirstName
        self.lastName = llastName
        self.age = aage
        self.email = eemail
        self.additionalNotes = aaditionalNotes
        
        //Non required Initialized Variabl0es
        self.phoneNumber = ""
        return
    }
    
    
    
    //Initialize with a Person class
    init (person: Person){
    
        self.firstName = person.firstName
        self.lastName = person.lastName
        self.age = person.age
        self.email = person.email
        self.additionalNotes = person.additionalNotes
        self.phoneNumber = person.phoneNumber
    
    
    
    }
    
    
    
    //Second initializer for when there is a phone number input
    init(firstName: String, lastName: String, isMentor: Bool, age: Int, email: String, phoneNumber: String, additionalNotes: String ) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.additionalNotes = additionalNotes
        self.phoneNumber = phoneNumber
        return
    }
    
    
//Blank initializer
    init() {
        self.firstName = ""
        self.lastName = ""
        self.isMentor = false
        self.age = 15
        self.email = ""
        self.additionalNotes = ""
        self.phoneNumber = ""
        return
    }
    
    
    
    
}

