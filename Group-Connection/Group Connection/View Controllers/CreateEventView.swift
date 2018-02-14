//
//  CreateEventView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class CreateEventView: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
MCSessionDelegate {
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var generalAccessCode: UITextField!
    @IBOutlet weak var mentorAccessCode: UITextField!
    @IBOutlet weak var groupName: UITextField!
    
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var checkInLength: UIStepper!
    
    @IBOutlet weak var mapView: UIImageView!
    
    @IBOutlet weak var mistakeLabel: UILabel!

    var imageWasTapped = false
    var checkInNumber: Int = 60
    let picker = UIImagePickerController()
    var SessionMC: MCSession!
    var advertisementAssistant: MCAdvertiserAssistant!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SessionMC = MCSession(peer: Globals.globals.user.peerid)
        SessionMC.delegate = Manager()
        picker.delegate = self
    }
    
    @IBAction func changeCheckInLength(_ sender: Any) {
        checkInNumber = Int(checkInLength.value)
        stepperLabel.text = "\(checkInNumber) min"
    }
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "To Join or Create", sender: nil)
    }

    @IBAction func makeGeneralCode(_ sender: Any) {
        generalAccessCode.text = Event.makeCode()
    }
    
    @IBAction func makeMentorCode(_ sender: Any) {
        mentorAccessCode.text = Event.makeCode()
    }
    
    @IBAction func makeEvent(_ sender: Any) {
        if checkInputs() {
            
            mistakeLabel.text = ""
            
            let event = Event(user: Globals.globals.user)
            
            event.eventName = eventName.text!
            event.checkInLength = checkInLength.value
            event.generalAccessCode = generalAccessCode.text!
            event.mentorAccessCode = mentorAccessCode.text!
            event.groupName = groupName.text!
            event.importedMap = mapView.image
            
            Globals.globals.event = event
            
            var accessCodeThing = event.generalAccessCode
            accessCodeThing = "accessCode"
            
            let fullName = Globals.globals.user.firstName + " " + Globals.globals.user.lastName
            
            advertisementAssistant = MCAdvertiserAssistant(serviceType: "accessCode", discoveryInfo: nil, session: SessionMC)
            advertisementAssistant.start()
            print("Advertising Started")
            mistakeLabel.text = "Advertising Started"
            print(accessCodeThing)

            //performSegue(withIdentifier: "To Main Tab", sender: nil)
        }
        else {
            mistakeLabel.text = "Please input all values correctly before proceeding."
        }
    }
    
    //check all inputs
    func checkInputs() -> Bool {
        let genCode = generalAccessCode.hasText
        let mencode = mentorAccessCode.hasText
        let event = eventName.hasText
        let group =  groupName.hasText
        let checkLen = checkInLength.value > 20
        let map = imageWasTapped
        print("there be a map = \(map)")
        return genCode && mencode && event && group && checkLen && map
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //lower any keyboards when the user taps anywhere besides a text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //photo stuff
    @IBAction func photoFromLibrary(_ sender: Any) {
        imageWasTapped = true
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage 
        mapView.contentMode = .scaleAspectFit
        mapView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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

