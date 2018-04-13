//
//  MentorView.swift
//  Group Connection
//
//  Created by NARANJO, DANIEL on 3/16/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import MultipeerConnectivity

class MentorView: Sub, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var buddyList: UILabel!
    @IBOutlet weak var userView: UILabel!
    @IBOutlet weak var timeSinceLabel: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var groupMessage: UIButton!
    @IBOutlet weak var buddyListTitle: UILabel!
    @IBOutlet weak var changeBuddy: UIButton!
    @IBOutlet weak var leaveVenue: UIButton!
    
    var rotation: CGFloat = 0
    var rotate = UIRotationGestureRecognizer()
    
    var students: [Person]!
    
    @objc func leaveVenue(_: Any) {
        //stub
        print("leaving venue")
    }
    
    @objc func sayHi(_: Any) {
        print("sup")
    }
    
    @objc func editTime(_ sender: Any?) {
        //stub
        print("editing time")
        let textBox = UITextField(frame: timeDisplay.frame)
        self.view.addSubview(textBox)
        self.reloadInputViews()
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
            //content.sound = UNNotificationSound.init(named: "toolur_5C4U7D.wav")
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
            content.subtitle = "You was an inspiration to me"
            //content.sound = UNNotificationSound.init(named: "Surprise Motherfcker Sound Effect ORIGINAL.mp3")
            content.badge = 31
            content.categoryIdentifier = "tupac"
            let identifier = "tupac"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            let data = try JSONEncoder().encode("panic")
            let mentors = Globals.getIDs(Globals.globals.getMentors())
            try Globals.globals.manager.session.send(data, toPeers: mentors, with: .reliable)
            print("triggered")
        }
        catch {
            print("panicking failed")
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.isCheckInView = true
        
        rotate = UIRotationGestureRecognizer(target: self, action: #selector(self.rotating))
        userView.addGestureRecognizer(rotate)
        userView.isUserInteractionEnabled = true
        userView.isMultipleTouchEnabled = true
        
        UNUserNotificationCenter.current().delegate = self
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(editTime(_:)))
        tapper.numberOfTapsRequired = 2
        timeDisplay.addGestureRecognizer(tapper)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("mentor disappear")
    }
    

}
