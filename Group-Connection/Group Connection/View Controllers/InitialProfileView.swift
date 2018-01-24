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
        
        
        if (firstName.hasText && lastName.hasText && ageText.hasText && phoneNumber.hasText && email.hasText)   {
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
        if !checkPhone(phone: phone) {return false}
        
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
        
        return true
    }
    
    func checkPhone(phone: String)->Bool {
        if isAllDigits(phone: phone) == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: phone)
        }
        else {
            return false
        }
    }
    
    func isAllDigits(phone: String)->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phone.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phone == filtered
    }
}


