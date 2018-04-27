//
//  Present.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 4/17/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Present: NSObject {
    
    var identifier: String
    
    var check: Check
    
    var message: String
    
    struct present : Codable{
        var identifier: String
        var check: Check.Xeck
        var message: String
        
        init(_ pres: Present) {
            check = Check.Xeck(pres.check)
            identifier = pres.identifier
            message = pres.message
        }
    }
    
    override init(){
    
        identifier = "Nothing"
        check = Check()
        message = ""
    }
    
    init(ident: String){
        identifier = ident
        check = Check()
        message = ""
    }
    
    init(ident: String, theCheck: Check){
        identifier = ident
        check = theCheck
        message = ""
    }
    
    init(ident: String, theCheck: Check, note: String){
        identifier = ident
        check = theCheck
        message = note
    }
    
    init(ident: String, note: String){
        identifier = ident
        check = Check()
        message = note
    }
    
    init(present: Present){
        identifier = present.identifier
        check = present.check
        message = present.message
        
    }
    
    
    
    
    
    
    
}
