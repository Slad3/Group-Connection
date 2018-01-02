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
        if firstName.hasText && lastName.hasText && subteam.hasText && ageText.hasText && phoneNumber.hasText && email.hasText  {
            mistakeLabel.text = ""
            let age: Int = Int(ageText.text!)!
            if age > 19 {
                let globals.user = Person(ffirstName: firstName.text!, llastName: lastName.text!,  iisMentor: true, aage: age, eemail: email.text!, aaditionalNotes: additionalNotes.text!)
                performSegue(withIdentifier: "To Join or Create", sender: nil)
            }
            else {
                let globals.user = Person(ffirstName: firstName.text!, llastName: lastName.text!,  iisMentor: false, aage: age, eemail: email.text!, aaditionalNotes: additionalNotes.text!)
                performSegue(withIdentifier: "To Join or Create", sender: nil)
            }
        }
        else {
            mistakeLabel.text = "Please input all values before proceeding."
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
    func imagePickerController(_ picker: UIImagePickerController,
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
