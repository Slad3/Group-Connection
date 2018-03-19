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

class JoinEventView: UIViewController, MCBrowserViewControllerDelegate {
    
    var accessCode: String = ""
    var creatorPeerid: MCPeerID!
    var connectedToSession = false
    
    //var SessionMC: MCSession! Used for testing purposes
    
    
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
        
        if !connectedToSession {
            connectedOrNot.backgroundColor = UIColor.red
            connectedOrNot.text = "Not Connected"
            TellUser.text = "Please find a session"
        }
            
        else {
            connectedOrNot.text = "Connected"
            connectedOrNot.backgroundColor = UIColor.green
            TellUser.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Join Event View Loading")
        
        if !connectedToSession{
            connectedOrNot.backgroundColor = UIColor.red
            connectedOrNot.text = "Not Connected"
        }
        
        //SessionMC = MCSession(peer: Globals.globals.user.peerid, securityIdentity: nil, encryptionPreference: .required)
        //Globals.globals.session = MCSession(peer: Globals.globals.user.peerid)
        Globals.globals.session = MCSession(peer: Globals.globals.globalPeerid, securityIdentity: nil, encryptionPreference: .required)
        Globals.globals.session.delegate = Manager()
    }
    
    @IBAction func FindSessions(_ sender: Any) {
        
        print("Start Function")
        
        if !accessCodeBox.hasText {
            accessCode = ""
        }
        else {
            accessCode = accessCodeBox.text!
        }
        //accessCode = "accessCode"
        let browserView = MCBrowserViewController(serviceType: accessCode, session: Globals.globals.session)
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
        //self.updateTextFields(fg: "The Group Name", en: "The Event Name", cn: "The Creator Name", di: "The Discription", connectionThere: false)
        self.connectedToSession = false
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
        
        creatorPeerid = peerID
        if(info != nil){
            self.updateTextFields(fg: info!["Group Name"]!, en: info!["Event Name"]!, cn: info!["Full Name"]!, di: info!["Discription"]!, connectionThere: true)
        }
        else{
            self.updateTextFields(fg: "The Group Name", en: "The Event Name", cn: "The Creator Name", di: "The Discription", connectionThere: true)
        }

        return true
    }
}
