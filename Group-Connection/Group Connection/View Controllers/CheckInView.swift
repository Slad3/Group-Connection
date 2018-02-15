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
    @IBOutlet weak var userView: UILabel!
    
    var rotation: CGFloat = 0
    var rotate = UIGestureRecognizer()
    
    @objc func rotating(_ sender: UIRotationGestureRecognizer) {
        self.view.bringSubview(toFront: userView)
        var originalRotation = CGFloat()
        let range = (CGFloat.pi / 3)...(2 * CGFloat.pi / 3)
        let range1 = (4 * CGFloat.pi / 3)...(5 * CGFloat.pi / 3)
        
        if sender.state == .began {
            sender.rotation = rotation
            originalRotation = sender.rotation
            print("begin")
        } else if sender.state == .changed {
            let newRotation = sender.rotation + originalRotation
            sender.view?.transform = CGAffineTransform(rotationAngle: newRotation)
            print(range.contains(newRotation))
            if range.contains(abs(newRotation)) || range1.contains(abs(newRotation)){
                //trigger panic
                panic()
                print("panic triggered")
            }
        } else if sender.state == .ended {
            rotation = 0
            sender.view?.transform = CGAffineTransform(rotationAngle: rotation)
            print("end")
        }
    }
    
    @IBAction func composeMessage(_ sender: Any) {
        //stub
    }
    
    @IBAction func changeBuddies(_ sender: Any) {
        //stub
    }
    
    private func panic() {
        //stub
        do {
            let data = try JSONEncoder().encode("panic")
            let mentors = Globals.getIDs(Globals.globals.getMentors())
            try Globals.globals.Session.send(data, toPeers: mentors, with: .reliable)
            print("triggered")
        }
        catch {
            print("panicking failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rotate = UIRotationGestureRecognizer(target: self, action: #selector(self.rotating(_:)) )
        userView.addGestureRecognizer(rotate)
        userView.isUserInteractionEnabled = true
        userView.isMultipleTouchEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

