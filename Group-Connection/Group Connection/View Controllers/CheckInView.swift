//
//  CheckInView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import Foundation
import MultipeerConnectivity
import UserNotifications

class CheckInView: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var buddyList: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var userView: UILabel!
    
    var rotation: CGFloat = 0
    var rotate = UIGestureRecognizer()
    
    @objc func sayHi(_: Any) {
        print("sup")
    }
    
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
        print("Notification")
        if Globals.globals.user.firstName == "Tupac" {
            let content = UNMutableNotificationContent()
            content.title = "RIP Bro"
            content.subtitle = "You was an inspiration to me"
            content.sound = UNNotificationSound.init(named: "toolur_5C4U7D.wav")
            print(Bool(UNNotificationSound(named: "toolur_sbCiis.wav") == content.sound))
            content.badge = 31
            content.categoryIdentifier = "tupac"
            
            let identifier = "tupac"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    @IBAction func changeBuddies(_ sender: Any) {
        //stub
    }
    
    private func panic() {
        //stub
        do {
            let content = UNMutableNotificationContent()
            content.title = "RIP Bro"
            content.subtitle = "Chlamydia, your dad's here!"
            content.sound = UNNotificationSound.init(named: "Surprise Motherfcker Sound Effect ORIGINAL.mp3")
            content.badge = 31
            content.categoryIdentifier = "tupac"
            let identifier = "tupac"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            let data = try JSONEncoder().encode("panic")
            let mentors = Globals.getIDs(Globals.globals.getMentors())
            try Globals.globals.session.send(data, toPeers: mentors, with: .reliable)
            print("triggered")
        }
        catch {
            print("panicking failed")
        }
        
    }
    //14 -
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //15 -
        completionHandler([.alert, .sound])
    }
    
    //16 -
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //17 -
        if response.actionIdentifier == "y = mx + b" {
            checkInLabel.text = "That's the correct answer!"
        } else if response.actionIdentifier == "Ax + By = C" {
            checkInLabel.text = "Sorry, that's the standard form equation."
        } else {
            checkInLabel.text = "Keep trying!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rotate = UIRotationGestureRecognizer(target: self, action: #selector(self.rotating(_:)) )
        userView.addGestureRecognizer(rotate)
        userView.isUserInteractionEnabled = true
        userView.isMultipleTouchEnabled = true
        
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

