//
//  ProfileView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit
import MessageUI

class ProfileView: Sub,  MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var subteam: UILabel!
    @IBOutlet weak var ageText: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var checkInStatus: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var addedNotes: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = Globals.globals.user
        
        fullName.text = user?.fullName
        subteam.text = "Subteam: " + (user?.subteam)!
        
        var temp = String(describing: user?.age)
        temp.removeFirst(9)
        temp.removeLast()
        ageText.text = "Age: " + temp
        
        group.text = "Group: " + ""
        
        temp = String(describing: user?.checkInStatus)
        temp.removeFirst(9)
        temp.removeLast()
        checkInStatus.text = "Status: " + temp
        
        phoneNumber.text = "Phone: " + (user?.phoneNumber)!
        emailText.text = "Email: " + (user?.email)!
        addedNotes.text = (user?.additionalNotes)
        let tempImage = user?.profilePhoto
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.image = tempImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func makeCall(_ sender: Any) {
    let url:NSURL = NSURL(string: "tel://" + Globals.globals.user.phoneNumber)!
        UIApplication.shared.openURL(url as URL)
    }
    
   
    @IBAction func sendThatEmail(_ sender: Any) {                                            
    
    if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
        composeVC.setToRecipients([Globals.globals.user.email])
            composeVC.setSubject("Hello!")
            composeVC.setMessageBody("Hello from California!", isHTML: false)
            
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
