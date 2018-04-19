//
//  InitialProfileView.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 12/15/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit
import MultipeerConnectivity
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
    
    var subteam: String! = Globals.globals.teamRoster[0].subteam
    var imagePressed: Bool = false
    
    let picker = UIImagePickerController()
    
    // Begin Pickerview-------------------------------------
    weak var pickerViewDataSource: UIPickerViewDataSource?
    
    let subTeam = ["Choose Subteam", "Mechanical", "Programming", "Control", "MTR", "Other"]
    
    func numberOfComponents(in subPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ subPicker: UIPickerView, titleForRow: Int, forComponent component: Int) -> String? {
        return subTeam[titleForRow]
    }
    
    func pickerView(_ subPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subTeam.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("did select row for subteam")
        subteam = subTeam[row]
    }
    //End PickerView------------------------------------------
    
    
    @IBAction func makeUser(_ sender: Any) {
        if (firstName.hasText && lastName.hasText && ageText.hasText && phoneNumber.hasText && email.hasText)   {
            
            let fName = firstName.text!
            let lName = lastName.text!
            let age: Int = Int(ageText.text!)!
            let eMail = email.text!
            let notes = additionalNotes.text!
            let subteam = self.subteam
            
            let phone = phoneNumber.text!
            var mentor = false
            
            if age > 19 {
                mentor = true
            }
            
            if checkInputs(age: ageText.text, email: eMail, phone: phone) {
                mistakeLabel.text = ""
                
                Globals.globals.initialized = true
                
                Globals.globals.user = Person(firstName: fName, lastName: lName, isMentor: mentor, age: age, email: eMail, phoneNumber: phone ,additionalNotes: notes, ssubteam: subteam!)
                
                if !Globals.globals.user.isMentor {
                    Globals.globals.user.mentor = Globals.globals.hans
                    print("hans is a mentor now")
                }
                
                Globals.globals.setPeerid(fullname: Globals.globals.user.fullName)
                
                Globals.globals.user.profilePhoto = profilePhoto.image
                
                Globals.globals.teamRoster[0] = Globals.globals.user
                
                print(Globals.globals.teamRoster[0].subteam)
                
                Person.encodeEveryone()
                
                
                if Globals.globals.user.isMentor { //Action Sheet Stuff
                    let actionSheet = UIAlertController(title: "Join or Create", message: "Do you want to Create or Join a session?", preferredStyle: .actionSheet)
                    
                    actionSheet.addAction(UIAlertAction(title: "Create Event", style: .default, handler: { (action:UIAlertAction) in
                        Person.encodeEveryone()
                        self.performSegue(withIdentifier: "To Create Event", sender: nil)
                    }))
                    
                    actionSheet.addAction(UIAlertAction(title: "Join Event", style: .default, handler: { (action:UIAlertAction) in
                        Person.encodeEveryone()
                        print("join event")
                        Globals.globals.inEvent = true
                        self.performSegue(withIdentifier: "toTabTemp", sender: nil)
                        //                        self.performSegue(withIdentifier: "To Join Event", sender: nil)
                    }))
                    
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action:UIAlertAction) in Globals.globals.initialized = false
                    } ))
                    
                    if let popoverController = actionSheet.popoverPresentationController{
                        popoverController.sourceView = self.view
                        popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                        popoverController.permittedArrowDirections = []
                    }
                    
                    self.present(actionSheet, animated: true, completion: nil)
                    
                }
                else {
                    //Action sheet Stuff
                    let actionSheet = UIAlertController(title: "Join Event", message: "", preferredStyle: .actionSheet)
                    
                    actionSheet.addAction(UIAlertAction(title: "Join Event", style: .default, handler: { (action:UIAlertAction) in
                        self.performSegue(withIdentifier: "toTabTemp", sender: nil)
                        //self.performSegue(withIdentifier: "To Join Event", sender: nil)
                    }))
                    
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    if let popoverController = actionSheet.popoverPresentationController{
                        popoverController.sourceView = self.view
                        popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                        popoverController.permittedArrowDirections = []
                    }
                    
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
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        if Globals.globals.initialized {
            let user = Globals.globals.user
            firstName.text = user?.firstName
            lastName.text = user?.lastName
            
            var temp = String(describing: user?.age)
            temp.removeFirst(9)
            temp.removeLast()
            ageText.text = temp
            
            phoneNumber.text = user?.phoneNumber
            email.text = user?.email
            additionalNotes.text = user?.additionalNotes
            profilePhoto.image = user?.profilePhoto
            
            let sub = user?.subteam
            let pickerNum: Int! = subTeam.index(of: sub!) ?? 0
            print(user?.subteam)
            subPicker.selectRow(pickerNum, inComponent: 0, animated: false)
            imagePressed = true
            mistakeLabel.text = "Nothing's broken. For real. Just tap Go and select where you want to go."
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y <= self.additionalNotes.frame.origin.y {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //photo stuff
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        profilePhoto.contentMode = .scaleAspectFit //3
        profilePhoto.image = chosenImage //4
        imagePressed = true
        dismiss(animated:true, completion: nil) //5
    }
    
    @IBAction func photoFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePressed = false
        dismiss(animated: true, completion: nil)
    }
    
    //started editing additionalNotes
    func textViewDidBeginEditing(_ textView: UITextView) {
        additionalNotes.text = ""
    }
    
    //check user inputs
    private func checkInputs(age: String?, email: String, phone: String) -> Bool {
        if !checkAge(age: age) {
            return false
        }
        
        if !checkEmail(email: email) {
            print ("email is broken")
            return false
        }
        
        if !checkPhone(phone: phone) {
            print("phone is broken")
            return false
        }
        
        if !imagePressed {
            print("no photo input")
            return false
        }

        return true
    }
    
    private func checkAge(age: String?) -> Bool {
        let edad = age!
        if Int(edad) == nil {return false}
        return true
    }
    
    private func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func checkPhone(phone: String)->Bool {
        let phoneRegex = "\\d*\\d*\\d*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return  predicate.evaluate(with: phone)
    }
    
    //lower any keyboards when the user taps anywhere besides a text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

