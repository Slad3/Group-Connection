//
//  JoinOrCreateViewController.swift
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
        print("Doing stuff pre-segue to Main Tab")
        let somethingWentWrong: Bool = false
        
        if somethingWentWrong {
            mistakeLabel.text = "Something went wrong. Sorry."
            return
        }
        
        
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

