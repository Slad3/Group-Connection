//
//  Present.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 4/17/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Present {
    
    var identifier: String
    
    var check: Check
    
    var message: String
    
    
    
    
    
    init(){
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
    
    
    
    
    
    
    
}
