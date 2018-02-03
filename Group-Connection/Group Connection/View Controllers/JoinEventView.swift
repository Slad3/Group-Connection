//
//  TestView.swift
//  Group Connection
//
//  Created by Ben on 2/2/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class JoinEventView: UIViewController, MCNearbyServiceBrowserDelegate {
    
    var accessCode: String = ""
    
    
    
    @IBOutlet weak var accessCodeBox: UITextField!
    
    @IBAction func FindSessions(_ sender: Any) {
        
        //var browserService = MCNearbyServiceBrowser(peer: Globals.globals.user.peerid, serviceType: accessCode)
        var browserService = MCNearbyServiceBrowser(peer: Globals.globals.user.peerid, serviceType: accessCode)
        browserService.delegate = self
        //self.present(, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        if (!accessCodeBox.hasText){
            accessCode = ""
        }
        else{
            accessCode = accessCodeBox.text!
        }
        
        Globals.globals.Session = MCSession(peer: Globals.globals.user.peerid, securityIdentity: nil, encryptionPreference: MCEncryptionPreference(rawValue: 0)!)
        Globals.globals.Session.delegate = Manager()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("Stuffs happenin")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Stuffs happenin")
    }
    
    
    
    
}
