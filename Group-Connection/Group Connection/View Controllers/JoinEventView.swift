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

class JoinEventView: UIViewController, MCNearbyServiceBrowserDelegate, MCBrowserViewControllerDelegate {

    
    var accessCode: String = ""
    var creatorPeerid: MCPeerID!
    
    
    @IBOutlet weak var accessCodeBox: UITextField!
    
    func updateTextFields() {
        
        
        
        
        
    }
    
    @IBAction func FindSessions(_ sender: Any) {
        print("Start Function")
        
        if (!accessCodeBox.hasText){
            accessCode = ""
        }
        else{
            accessCode = accessCodeBox.text!
        }
        
        
        let browserView = MCBrowserViewController(serviceType: accessCode, session: Globals.globals.Session)
        print("Made Browser View")
        browserView.delegate = self
        print("made delegate")
        
        self.present(browserView, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Join Event View Loading")
   
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
    
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("Found Peer")
        
        creatorPeerid = peerID
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("lost peer")
        
        
    }
    
    
    
    
}
