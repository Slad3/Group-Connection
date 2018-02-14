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

class JoinEventView: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate {
    
    var accessCode: String = ""
    var creatorPeerid: MCPeerID!
    var connectedToSession = false
    var SessionMC: MCSession!
    
    
    @IBOutlet weak var accessCodeBox: UITextField!
    
    @IBOutlet weak var FoundGroupText: UILabel!
    
    @IBOutlet weak var EventNameText: UILabel!
    
    @IBOutlet weak var CreatorNameText: UILabel!
    
    @IBOutlet weak var DiscriptionText: UILabel!
    
    @IBOutlet weak var connectedOrNot: UILabel!
    
    @IBOutlet weak var TellUser: UILabel!
    
    
    @IBAction func advance(_ sender: Any) {
        if(connectedToSession){
            //add stuff here for session stuff if we need to
            
            
            performSegue(withIdentifier: "To Main", sender: nil)
        }
    }
    
    
    
    func updateTextFields(fg: String, en: String, cn: String, di: String, connectionThere: Bool) {
        
        FoundGroupText.text = fg
        EventNameText.text = en
        CreatorNameText.text = cn
        DiscriptionText.text = di
        connectedToSession = connectionThere
        
        if(!connectedToSession){
            connectedOrNot.backgroundColor = UIColor.red
            connectedOrNot.text = "Not Connected"
            TellUser.text = "Please find a session"
            
        }
        else{
            connectedOrNot.text = "Connected"
            connectedOrNot.backgroundColor = UIColor.green
            TellUser.text = ""
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Join Event View Loading")
        
        if(!connectedToSession){
            connectedOrNot.backgroundColor = UIColor.red
            connectedOrNot.text = "Not Connected"
        }
        
        //SessionMC = MCSession(peer: Globals.globals.user.peerid, securityIdentity: nil, encryptionPreference: .required)
        SessionMC = MCSession(peer: Globals.globals.user.peerid)
        SessionMC.delegate = Manager()
        
    }
    
    
    @IBAction func FindSessions(_ sender: Any) {
        print("Start Function")
        
        if (!accessCodeBox.hasText){
            accessCode = ""
        }
        else{
            accessCode = accessCodeBox.text!
        }
        accessCode = "accessCode"
        let browserView = MCBrowserViewController(serviceType: "accessCode", session: SessionMC)
        browserView.delegate = self
        
        print("Made Browser View")
        //print(accessCode)
        print("made delegate")
        
        self.present(browserView, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //lower any keyboards when the user taps anywhere besides a text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
//        updateTextFields(fg: info["GroupName"]!, en: info["EventName"]!, cn: info["CreatorName"]!, di: info["Discription"]!, connectionThere: true)
        self.connectedToSession = true
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        self.updateTextFields(fg: "The Group Name", en: "The Event Name", cn: "The Creator Name", di: "The Discription", connectionThere: false)
        self.connectedToSession = false
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool{
        
        creatorPeerid = peerID
        //updateTextFields(fg: info!["GroupName"]!, en: info!["EventName"]!, cn: info!["CreatorName"]!, di: info!["Discription"]!, connectionThere: true)
        self.updateTextFields(fg: "The Group Name", en: "The Event Name", cn: "The Creator Name", di: "The Discription", connectionThere: true)

        return true
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}
