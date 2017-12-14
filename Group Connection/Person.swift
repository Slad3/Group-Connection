//
//  Person.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation

class Person {

    var firstName: String
    
    var lastName: String
    
    var isMentor: Bool
    
    var age: Int
    
    var phoneNumber: String
    
    var email: String
    
    var additionalNotes: String
    
    var buddy1: Person
    
    var buddy2: Person
    
    
    init(ffirstName: String, llastName: String, iisMentor: Bool, aage: Int, eemail: String, aaditionalNotes: String){
    
        
        //Required Initialized Variables
        self.firstName = ffirstName
        self.lastName = llastName
        self.isMentor = iisMentor
        self.age = aage
        self.email = eemail
        self.additionalNotes = aaditionalNotes
        
        //Non required Initialized Variables
        self.phoneNumber = ""
        self.buddy1 = Person()
        self.buddy2 = Person()
        
 
        
    
    }
    
    
    
    
    
    
    
    
    init(){
      
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
