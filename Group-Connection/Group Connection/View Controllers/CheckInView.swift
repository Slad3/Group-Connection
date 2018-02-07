//
//  CheckInView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
//import Foundation
import MultipeerConnectivity

class CheckInView: UIViewController {
    @IBOutlet weak var buddyList: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    
    @IBAction func Panic(_ sender: UIRotationGestureRecognizer) {
        //stub
        print("panicking. AHHHGHGHHGHGHHG")
    }
    @IBAction func composeMessage(_ sender: Any) {
        //stub
    }
    
    @IBAction func changeBuddies(_ sender: Any) {
        //stub 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
