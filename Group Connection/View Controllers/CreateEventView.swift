//
//  CreateEventView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class CreateEventView: UIViewController {
    
    @IBOutlet weak var eventName: UITextField!

    @IBOutlet weak var checkInLength: UIStepper!
    @IBOutlet weak var generalAccessCode: UITextField!
    @IBOutlet weak var lengthLable: UILabel!
    
    
    @IBAction func stepper(_ sender: UIStepper){
    
    lengthLable.text = String(sender.value)
    
    
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func makeEvent(_ sender: Any) {
        let event = Event()
        event.eventName = eventName.text!
        event.checkInLength = checkInLength.value
        event.generalAccessCode = generalAccessCode.text ?? Event.makeCode()
        event.mentorAccessCode = Event.makeCode() 
    }
    
}

