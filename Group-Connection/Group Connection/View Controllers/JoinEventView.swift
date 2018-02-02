//
//  JoinEventView.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 12/15/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class JoinEventView: MCBrowserViewController /*UIViewController*/  {
    
    var accesscode: String = "robots"
    
    var browserService: MCNearbyServiceBrowser!
    
    
    @IBOutlet weak var accessCode: UITextField!
    
   // @IBOutlet weak var mistakeLabel: UILabel!
    

    
    override func viewDidLoad() {
        print("Join event view Loading")
        super.viewDidLoad()
        Globals.globals.Session = MCSession(peer: Globals.globals.user.peerid, securityIdentity: nil, encryptionPreference: MCEncryptionPreference(rawValue: 0)!)
        Globals.globals.Session.delegate = Manager() as MCSessionDelegate
        print("Session Started")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
