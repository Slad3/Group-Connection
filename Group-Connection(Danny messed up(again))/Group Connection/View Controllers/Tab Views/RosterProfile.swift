//  RosterProfileView.swift
//  Group Connection
//
//  Created by BURRIGHT, NICHOLAS on 2/14/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation 
import UIKit
import MessageUI

class RosterProfileView: UIViewController ,MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var rFullName: UILabel!
    @IBOutlet weak var rProfilePhoto: UIImageView!
    @IBOutlet weak var rSubteam: UILabel!
    @IBOutlet weak var rAge: UILabel!
    @IBOutlet weak var rGroup: UILabel!
    @IBOutlet weak var rStatus: UILabel!
    @IBOutlet weak var rPhone: UILabel!
    @IBOutlet weak var rEmail: UILabel!
    @IBOutlet weak var rAdditionalNotes: UILabel!
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "To Main Tab", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let user = Globals.globals.teamRoster[Globals.globals.selectedIndex]
        
        rFullName.text = user.fullName
        rSubteam.text = "Subteam: " + user.subteam
        
        var temp = String(describing: user.age)
        if temp.count > 3 {
            temp.removeFirst(9)
            temp.removeLast()
        }
        
        rAge.text = "Age: " + temp
        rGroup.text = "Group: " + ""
        temp = String(describing: user.checkInStatus)
        
        if temp.count > 6 {
            temp.removeFirst(9)
            temp.removeLast()
        }
        
        rStatus.text = "Status: " + temp
        rPhone.text = "Phone: " + user.phoneNumber
        rEmail.text = "Email: " + user.email
        rAdditionalNotes.text = user.additionalNotes
        rProfilePhoto.image = user.profilePhoto
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeTheCall(_ sender: Any) {
        let url:NSURL = NSURL(string: "tel://" + Globals.globals.teamRoster[Globals.globals.selectedIndex].phoneNumber)!
        UIApplication.shared.openURL(url as URL)
    }
    
    @IBAction func sendThatEmail(_ sender: Any) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([Globals.globals.teamRoster[Globals.globals.selectedIndex].email])
            composeVC.setSubject("Hello!")
            composeVC.setMessageBody("", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
  
}
