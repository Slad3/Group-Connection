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
UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
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
        
        
        if (firstName.hasText && lastName.hasText && ageText.hasText && phoneNumber.hasText && email.hasText)   {
            
        
            let fName = firstName.text!
            let lName = lastName.text!
            let age: Int = Int(ageText.text!)!; print("user age is \(age)")
            let eMail = email.text!
            let notes = additionalNotes.text!
            let subteam = picker.description
            let phone = phoneNumber.text!
            var mentor = false
        
            if age > 19 {
                mentor = true
                print("iisMentor is true")
            }
            
            if checkInputs(age: ageText.text, email: eMail, phone: phone) {
                mistakeLabel.text = ""
                Globals.globals.initialized = true
                Globals.globals.user = Person(firstName: fName, lastName: lName, isMentor: mentor, age: age, email: eMail, phoneNumber: phone ,additionalNotes: notes, ssubteam: subteam)
                if Globals.globals.teamRoster != nil {
                    Globals.globals.teamRoster.append(Globals.globals.user)
                }
                else {
                    Globals.globals.teamRoster = [Globals.globals.user]
                    print("roster was empty")
                }
                
                
                if (Globals.globals.user.isMentor) { //Action Sheet Stuff
                    let actionSheet = UIAlertController(title: "Join or Create", message: "Do you want to Create or Join a session?", preferredStyle: .actionSheet)
                    
                    actionSheet.addAction(UIAlertAction(title: "Create Event", style: .default, handler: { (action:UIAlertAction) in
                        
                        self.performSegue(withIdentifier: "To Create Event", sender: nil)
                        
                    }))
                    actionSheet.addAction(UIAlertAction(title: "Join Event", style: .default, handler: { (action:UIAlertAction) in self.performSegue(withIdentifier: "To Join Event", sender: nil)
                    }))
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    self.present(actionSheet, animated: true, completion: nil)
                    
                }
                else {
                    //Action sheet Stuff
                    let actionSheet = UIAlertController(title: "Join", message: "", preferredStyle: .actionSheet)
                    
                    actionSheet.addAction(UIAlertAction(title: "Join Event", style: .default, handler: { (action:UIAlertAction) in self.performSegue(withIdentifier: "To Join Event", sender: nil)
                    }))
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    self.present(actionSheet, animated: true, completion: nil)
                }
            }
            else { //if checkInputs() == false
                 mistakeLabel.text = "Please input all values correctly before proceeding."
            }
        }
        else { //if no text
            mistakeLabel.text = "Please input all values correctly before proceeding."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        additionalNotes.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        if !checkAge(age: age) {return false}  // this is working
        if !checkEmail(email: email)
        {
            print ("email is broken")
            return false

        }
        if !checkPhone(phone: phone)
        {
            print("phone is broken")
            return false

        }
        
        return true
    }
    
    func checkAge(age: String?) -> Bool {
        let edad = age!
        if Int(edad) == nil {return false}
        return true
    }
    
    func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func checkPhone(phone: String)->Bool {
            let phoneRegex = "\\d*\\d*\\d*"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: phone)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        additionalNotes.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
