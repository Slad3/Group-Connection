//
//  CreateEventView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class CreateEventView: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var generalAccessCode: UITextField!
    @IBOutlet weak var mentorAccessCode: UITextField!
    @IBOutlet weak var groupName: UITextField!
    
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var checkInLength: UIStepper!
    
    @IBOutlet weak var mapView: UIImageView!
    @IBOutlet weak var mistakeLabel: UILabel!
    
    @IBAction func changeCheckInLength(_ sender: Any) {
        let checkInNumber = Int(checkInLength.value)
        stepperLabel.text = "\(checkInNumber) min"
    }
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "To Join or Create", sender: nil)
    }
    
    
    @IBAction func makeGeneralCode(_ sender: Any) {
        event.generalAccessCode = Event.makeCode()
        generalAccessCode.text = event.generalAccessCode
    }
    
    @IBAction func makeMentorCode(_ sender: Any) {
        event.mentorAccessCode = Event.makeCode()
        mentorAccessCode.text = event.mentorAccessCode
    }
    
    @IBAction func photoFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func makeEvent(_ sender: Any) {
        if generalAccessCode.hasText && mentorAccessCode.hasText && eventName.hasText && (checkInLength.value > 0.0) {
            mistakeLabel.text = ""
            event.eventName = eventName.text!
            event.checkInLength = checkInLength.value
            event.generalAccessCode = generalAccessCode.text ?? Event.makeCode()
            event.mentorAccessCode = Event.makeCode()
            
            print("Event has been made!!")
            
            performSegue(withIdentifier: "To Main Tab", sender: nil)
        }
        else {
            mistakeLabel.text = "Please input all values before proceeding."
        }
    }
    
    var event: Event = Event()
    let picker = UIImagePickerController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        mapView.contentMode = .scaleAspectFit //3
        mapView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
        event.importedMap = mapView.image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

