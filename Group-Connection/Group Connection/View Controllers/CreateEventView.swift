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
UINavigationControllerDelegate {
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var generalAccessCode: UITextField!
    @IBOutlet weak var groupName: UITextField!
    
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var checkInLength: UIStepper!
    
    @IBOutlet weak var mapView: UIImageView!
    
    @IBOutlet weak var mistakeLabel: UILabel!

    var imageWasTapped = false
    var checkInNumber: Int = 60
    let picker = UIImagePickerController()
    //var SessionMC: MCSession!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //Globals.globals.session = MCSession(peer: Globals.globals.user.peerid)
        Globals.globals.session = MCSession(peer: Globals.globals.user.peerid, securityIdentity: nil, encryptionPreference: .optional)
        Globals.globals.session.delegate = Manager()

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
    

    @IBAction func makeEvent(_ sender: Any) {
        if checkInputs() {
            
            mistakeLabel.text = ""
            
            let event = Event(user: Globals.globals.user)
            
            event.eventName = eventName.text!
            event.checkInLength = checkInLength.value
            event.generalAccessCode = generalAccessCode.text!
            event.groupName = groupName.text!
            event.importedMap = mapView.image
            
            Globals.globals.event = event
            
            let accessCodeThing = event.generalAccessCode
            //accessCodeThing = "accessCode"
            
            let fullName = Globals.globals.user.peerid.displayName
            Globals.globals.isCreator = true
            Globals.globals.passingData = (accessCodeThing, groupName.text!, event.eventName, fullName, "discription")

            performSegue(withIdentifier: "To Main Tab", sender: nil)
        }
            
        else {
            mistakeLabel.text = "Please input all values correctly before proceeding."
        }
    }
    

    
    
    //check all inputs
    func checkInputs() -> Bool {
    
        let event = eventName.hasText
        let group =  groupName.hasText
        let checkLen = checkInLength.value > 20
        let map = imageWasTapped
        var genCode: Bool
        
        if generalAccessCode.hasText{
            let lengthGood = (generalAccessCode.text!.count < 16) && (generalAccessCode.text!.count > 1)
            let characters = "[A-Z0-9a-z]"
            let characterTest = NSPredicate(format:"SELF MATCHES %@", characters)
            let charactersGood = characterTest.evaluate(with: generalAccessCode.text!)
            
            if lengthGood && charactersGood {
                genCode = true
            }
            else {
                genCode = false
            }
        }
        else {
            genCode = false
        }
        return genCode && event && group && checkLen && map
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
}

