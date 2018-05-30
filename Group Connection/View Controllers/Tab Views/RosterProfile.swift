//  RosterProfileView.swift
//  Group Connection
//
//  Created by BURRIGHT, NICHOLAS on 2/14/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation 
import UIKit
import MessageUI

class RosterProfileView: UIViewController, MFMailComposeViewControllerDelegate {
    
    
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
    
    @IBAction func makeACall(_ sender: Any) {
        let url:NSURL = NSURL(string: "tel://" + user.phoneNumber)!
        UIApplication.shared.openURL(url as URL)
    }
    
    var user: Person!
    
    @IBAction func sendAnEmail(_ sender: Any) {
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([user.email])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody("Hello from California!", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
        func mailComposeController(controller: MFMailComposeViewController,
                                   didFinishWithResult result: MFMailComposeResult, error: NSError?) {
            // Check the result or perform other tasks.
            
            // Dismiss the mail compose view controller.
            controller.dismiss(animated: true, completion: nil)
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        user = Globals.globals.teamRoster[Globals.globals.selectedIndex]
        
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
        //rProfilePhoto.image = user.profilePhoto
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
