//
//  JoinOrCreatViewController.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/5/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit


class JoinOrCreateViewController: UIViewController {
    
    
    @IBOutlet weak var accessCode: UITextField!
    
    @IBOutlet weak var mistakeLabel: UILabel!
    
    @IBAction func checkCode(_ sender: Any) {
        //implement moar stuff here please
        
        performSegue(withIdentifier: "To Main Tab", sender: nil)
    }
   
    
    
    @IBAction func create(_ sender: Any) {
        
        
        
        
        //filter out students
        if let hold = globals.user?.age {
            if hold >= 19 {
                return
            }
        }
 
        
        
        
        performSegue(withIdentifier: "To Create", sender: nil)
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

