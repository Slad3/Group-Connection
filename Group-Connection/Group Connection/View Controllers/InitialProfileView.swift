//
//  InitialProfileView.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 12/15/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit

class InitialProfileView: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var additionalNotes: UITextView!
    @IBOutlet weak var mistakeLabel: UILabel!
    @IBOutlet weak var subteam: UITextField!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    let picker = UIImagePickerController()
    
    @IBAction func photoFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func makeUser(_ sender: Any) {
        print("Button got pressed")
        
        
        //Phone Number Check
        var phoneNumberGood = false
        if (phoneNumber.hasText && phoneNumber.text?.count == 10){
            phoneNumberGood = true
        }
        
        
        //Subteam check and formatting
        var subTeamGood = false
        if (subteam.hasText){
            let tempSubteam = subteam.text?.lowercased()
            subteam.text = tempSubteam
            subTeamGood = true
        }
        
        
        
        
        
        
        
        //
        //   Do the subteam stuff for constructor asuhdfil
        //
        
        if firstName.hasText && lastName.hasText && ageText.hasText && phoneNumberGood && email.hasText && subTeamGood  {
            mistakeLabel.text = ""
            let age: Int = Int(ageText.text!)!
            if age > 19 {
                globals.user = Person(ffirstName: firstName.text!, llastName: lastName.text!,  iisMentor: true, aage: age, eemail: email.text!, aaditionalNotes: additionalNotes.text!, ssubteam: subteam.text!)
                performSegue(withIdentifier: "To Join or Create", sender: nil)
            }
            else {
                globals.user = Person(ffirstName: firstName.text!, llastName: lastName.text!,  iisMentor: false, aage: age, eemail: email.text!, aaditionalNotes: additionalNotes.text!, ssubteam: subteam.text!)
                performSegue(withIdentifier: "Join Event", sender: nil)
            }
        }
        else {
            mistakeLabel.text = "Please input all values correctly before proceeding."
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates
    @nonobjc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        profilePhoto.contentMode = .scaleAspectFit //3
        profilePhoto.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
