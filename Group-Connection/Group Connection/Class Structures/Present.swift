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
    
    var panic: Panic
    
    struct present : Codable{
        var identifier: String
        var check: Check.Xeck
        var message: String
        var panic: Panic.penac
        
        init(_ pres: Present) {
            check = Check.Xeck(pres.check)
            identifier = pres.identifier
            message = pres.message
            panic = Panic.penac(pres.panic)
        }
    }
    
    override init(){
    
        identifier = "Nothing"
        check = Check()
        message = ""
        panic = Panic()
    }
    
    init(ident: String){
        identifier = ident
        check = Check()
        message = ""
        panic = Panic()
    }
    
    init(ident: String, theCheck: Check){
        identifier = ident
        check = theCheck
        message = ""
        panic = Panic()
    }
    
    init(ident: String, theCheck: Check, note: String){
        identifier = ident
        check = theCheck
        message = note
        panic = Panic()
    }
    
    init(ident: String, note: String){
        identifier = ident
        check = Check()
        message = note
        panic = Panic()
    }
    
    init(present: Present.present){
        identifier = present.identifier
        check = Check(present.check)
        message = present.message
        panic = Panic(present.panic)
        
    }
    
    init(present: Event){}
    
    
    
    
    
    
    
}
