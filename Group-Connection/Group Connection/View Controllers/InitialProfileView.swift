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
UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var additionalNotes: UITextView!
    @IBOutlet weak var mistakeLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var subPicker: UIPickerView!
    
    weak var pickerViewDataSource: UIPickerViewDataSource?
    
    let subTeam = ["Mechanical", "Programming", "Control", "MTR", "Other"]
    
    func numberOfComponents(in subPicker: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ subPicker: UIPickerView, titleForRow: Int, forComponent component: Int) -> String?
    {
        return subTeam[titleForRow]
    }
    
    func pickerView(_ subPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return subTeam.count
    }
    
    
    
    
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
        if (phoneNumber.hasText && phoneNumber.text?.characters.count == 10){
            phoneNumberGood = true
        }
        
        //
        //        //Subteam check and formatting
        //        var subTeamGood = false
        //        if (subteam.hasText){
        //            let tempSubteam = subteam.text?.lowercased()
        //            subteam.text = tempSubteam
        //            subTeamGood = true
        //        }
        //
        //
        
        
        
        
        
        //
        //   Do the subteam stuff for constructor asuhdfil
        //
        
        if firstName.hasText && lastName.hasText && ageText.hasText && phoneNumber.hasText && email.hasText  {
            mistakeLabel.text = ""
            
            
            
            let fName = firstName.text!
            let lName = lastName.text!
            let age: Int = Int(ageText.text!)!; print("user age is \(age)")
            let eMail = email.text!
            let notes = additionalNotes.text!
            let subteam = picker.description
            var mentor = false
            var destination = "Join Event"
            
            if age > 19 {
                mentor = true
                print("iisMentor is true")
                destination = "To Join or Create"
            }
            
            globals.user = Person(ffirstName: fName, llastName: lName, iisMentor: mentor, aage: age, eemail: eMail, aaditionalNotes: notes, ssubteam: subteam)
            performSegue(withIdentifier: destination, sender: nil)
        }
        else { //if bad input
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
    
    
    func checkInputs(age: String?, email: String, phone: String) -> Bool {
        if !checkAge(age: age) {return false}
        if !checkEmail(email: email) {return false}
        if !checkPhoneNumber(phone: phone) {return false}
        
        return true
    }
    
    func checkAge(age: String?) -> Bool {
        let edad = age!
        if Int(edad) == nil {return false}
        return true
    }
    
    func checkEmail(email: String) -> Bool {
        
        return true
    }
    
    func checkPhoneNumber(phone: String) -> Bool {
        
        return true
    }
}

