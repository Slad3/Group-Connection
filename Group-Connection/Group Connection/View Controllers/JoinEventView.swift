//
//  JoinEventView.swift
//  Group Connection
//
//  Created by Daniel e. Naranjo Sampson on 12/15/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit

class JoinEventView: UIViewController {
    
    @IBOutlet weak var accessCode: UITextField!
    
    @IBOutlet weak var mistakeLabel: UILabel!
    
    @IBAction func checkCode(_ sender: Any) {
        //implement moar stuff here please
        
        performSegue(withIdentifier: "To Main Tab", sender: nil)
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
