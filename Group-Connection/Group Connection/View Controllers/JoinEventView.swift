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
    var connectedToSession = false
    
    
    @IBOutlet weak var accessCodeBox: UITextField!
    
    @IBOutlet weak var FoundGroupText: UILabel!
    
    @IBOutlet weak var EventNameText: UILabel!
    
    @IBOutlet weak var CreatorNameText: UILabel!
    
    @IBOutlet weak var DiscriptionText: UILabel!
    
    @IBOutlet weak var connectedOrNot: UILabel!
    
    @IBAction func advance(_ sender: Any) {
        if(connectedToSession){
            //add stuff here for session stuff if we need to
            
            
            performSegue(withIdentifier: "To Main", sender: nil)
        }
    }
    
    
    
    func updateTextFields(fg: String, en: String, cn: String, di: String) {
        
        FoundGroupText.text = fg
        EventNameText.text = en
        CreatorNameText.text = cn
        DiscriptionText.text = di
        connectedToSession = true
        connectedOrNot.text = "Connected"
        connectedOrNot.backgroundColor = UIColor.green
        

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
        
        if(!connectedToSession){
            connectedOrNot.backgroundColor = UIColor.red
            connectedOrNot.text = "Not Connected"
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
        
        //updateTextFields(fg: <#T##String#>, en: <#T##String#>, cn: <#T##String#>, di: <#T##String#>)
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("lost peer")
        
        
    }
    
    
    
    
}
