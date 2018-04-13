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

class CheckInView: Sub, UNUserNotificationCenterDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // @IBOutlet weak var buddyList: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var userView: UILabel!
    @IBOutlet weak var timeSinceLabel: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var groupMessage: UIButton!
    // @IBOutlet weak var buddyListExtension: UILabel!
    // @IBOutlet weak var buddyListTitle: UILabel!
    @IBOutlet weak var changeBuddy: UIButton!
    //@IBOutlet weak var title: UINavigationBar!
    @IBOutlet weak var table: UITableView!
    
    var rotation: CGFloat = 0
    var rotate = UIGestureRecognizer()
    
    var students: [Person]!
    
    
    @objc func leaveVenue(_: Any) {
        //stub
        print("leaving venue")
    }
    
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
            //content.sound = UNNotificationSound.init(named: "toolur_5C4U7D.wav")
            print(Bool(UNNotificationSound(named: "toolur_sbCiis.wav") == content.sound))
            content.badge = 31
            content.categoryIdentifier = "tupac"
            
            let identifier = "tupac"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    
    
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Globals.globals.user.buddyList.count )
        print("Buddy count")
        
        return Globals.globals.user.buddyList.count
    }
    
    
    // tells what should be displayed in each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //test this here
        let buddyCell = tableView.dequeueReusableCell(withIdentifier: "buddyCell", for: indexPath) as! BuddyTable
        buddyCell.buddyName.text = Globals.globals.user.buddyList[indexPath.row].fullName
        if Globals.globals.user.buddyList[indexPath.row].checkInStatus {
            print("buddy thing is yes true da")
            buddyCell.statusPic.image = UIImage(contentsOfFile: "heavy-check-,arl_2714.png")
            buddyCell.statusPic.contentMode = .scaleAspectFit
        }
        else {
            print("buddy thing is yes true da")
            
            buddyCell.statusPic.image = UIImage(contentsOfFile: "Red-X.svg")
            buddyCell.statusPic.contentMode = .scaleAspectFit
        }
        return buddyCell
    }
    
    
    @IBAction func changeBuddies(_ sender: Any) {
        
        performSegue(withIdentifier: "ToBuddyRoster", sender: nil)
        
        print("change buddies")
        
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
        table.delegate = self
        table.dataSource = self
        
        table.reloadData()
        
        super.isCheckInView = true
        
        rotate = UIRotationGestureRecognizer(target: self, action: #selector(self.rotating(_:)) )
        userView.addGestureRecognizer(rotate)
        userView.isUserInteractionEnabled = true
        userView.isMultipleTouchEnabled = true
        
        UNUserNotificationCenter.current().delegate = self
        
        self.hidesBottomBarWhenPushed = false
        
//        if Globals.globals.event != nil {
//            accessCode.text = Globals.globals.event.generalAccessCode
//        }
//        else {
//            accessCode.text = "Here's your code, Ben"
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
        print("viewdid appear")
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


