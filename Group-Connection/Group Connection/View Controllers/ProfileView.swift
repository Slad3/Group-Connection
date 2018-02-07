//
//  ProfileView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var subteam: UILabel!
    @IBOutlet weak var ageText: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var checkInStatus: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var addedNotes: UILabel!
    
    
    
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
        addedNotes.text = (user?.additionalNotes)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
