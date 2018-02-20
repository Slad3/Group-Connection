//
//  RosterProfileView.swift
//  Group Connection
//
//  Created by BURRIGHT, NICHOLAS on 2/14/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit


class RosterProfileView: UIViewController {
    
  
    @IBOutlet weak var rFullName: UILabel!
    @IBOutlet weak var rProfilePhoto: UIImageView!
    @IBOutlet weak var rSubteam: UILabel!
    @IBOutlet weak var rAge: UILabel!
    @IBOutlet weak var rGroup: UILabel!
    @IBOutlet weak var rStatus: UILabel!
    @IBOutlet weak var rPhone: UILabel!
    @IBOutlet weak var rEmail: UILabel!
    @IBOutlet weak var rAdditionalNotes: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let user = Globals.globals.user 
        rFullName.text = user?.fullName
        rSubteam.text = "Subteam: " + (user?.subteam)!
        var temp = String(describing: user?.age)
        temp.removeFirst(9)
        temp.removeLast()
        rAge.text = "Age: " + temp
        rGroup.text = "Group: " + ""
        temp = String(describing: user?.checkInStatus)
        temp.removeFirst(9)
        temp.removeLast()
        rStatus.text = "Status: " + temp
        rPhone.text = "Phone: " + (user?.phoneNumber)!
        rEmail.text = "Email: " + (user?.email)!
        rAdditionalNotes.text = (user?.additionalNotes)!
        //  rProfilePhoto.image = user?.profilePhoto
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

