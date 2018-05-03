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

class MentorView: Sub, UNUserNotificationCenterDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userView: UILabel! //the panic button. Why I didn't call it panic is beyond me
    @IBOutlet weak var timeSinceLabel: UILabel! //the label
    @IBOutlet weak var timeEditor: UIDatePicker!
    @IBOutlet weak var groupMessage: UIButton!
    @IBOutlet weak var buddyListTitle: UILabel!
    @IBOutlet weak var changeBuddy: UIButton!
    @IBOutlet weak var leaveVenue: UIButton!
    @IBOutlet weak var accessCode: UILabel!
    @IBOutlet weak var table: UITableView!

    var rotation: CGFloat = 0
    var rotate = UIRotationGestureRecognizer()
    var textBox: UITextField!
    
    var students: [Person]!
    
    @objc func leaveVenue(_: Any) {
        //stub
        print("leaving venue")
    }
    
    @objc func sayHi(_: Any) {
        print("sup")
    }
    
    @objc func editTime(_ sender: UIDatePicker) {
        //stub
        accessCode.text = timeEditor.countDownDuration.stringFormatted()
        Globals.globals.checkInTime = timeEditor.countDownDuration
        //send check in time to students 
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
        performSegue(withIdentifier: "toBuddyRoster", sender: nil)
    }
    
    private func panic() {
        //stub
        do {
            let data = try JSONEncoder().encode("panic")
            let mentors = Globals.getIDs(Globals.globals.getMentors())
            try Globals.globals.manager.session.send(data, toPeers: mentors, with: .reliable)
            print("triggered")
        }
        catch {
            print("panicking failed")
        }
        
    }
    
    private func tupac() {
        
    }
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.globals.user.buddyList.count
    }
    
    
    // tells what should be displayed in each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //test this here
        let buddyCell = tableView.dequeueReusableCell(withIdentifier: "buddyCell", for: indexPath) as! BuddyTable
        
        buddyCell.buddyName.text = Globals.globals.user.buddyList[indexPath.row].fullName
        
        //delete
        Globals.globals.user.buddyList[indexPath.row].checkInStatus = true
        //------
        
        if Globals.globals.user.buddyList[indexPath.row].checkInStatus {
            //change for obvious reasons
            buddyCell.statusPic.image = UIImage(named: "obama.jpg_large")
            //--------------------------
            
            buddyCell.statusPic.contentMode = .scaleAspectFit
        }
        else {
            //change for obvious reasons (again)
            let chosenImage = UIImage(named: "zucc.jpg")
            //-------------------------
            
            buddyCell.statusPic.image = chosenImage
            buddyCell.statusPic.clipsToBounds = true
        }
        return buddyCell
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.isCheckInView = true
        UNUserNotificationCenter.current().delegate = self
        
        //rotate panic
        rotate = UIRotationGestureRecognizer(target: self, action: #selector(self.rotating))
        userView.addGestureRecognizer(rotate)
        userView.isUserInteractionEnabled = true
        userView.isMultipleTouchEnabled = true
        
        //timer thing
        timeEditor.addTarget(self, action: #selector(editTime(_:)), for: .valueChanged)
        timeEditor.countDownDuration = TimeInterval()
        
        //delete 
        accessCode.text = "00:00.0"
        //------
        
        table.delegate = self
        table.dataSource = self
        
        table.reloadData()
    
        if Globals.globals.user.buddyList.count < 2 {
            changeBuddy.titleLabel?.text = "Add Student"
        }
        
        if Globals.globals.event != nil {
            accessCode.text = Globals.globals.event.generalAccessCode
        }
        else {
            accessCode.text = "Here's your code, Ben"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("mentor disappear")
    }
    
    //lower any keyboards when the user taps anywhere besides a text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension TimeInterval {
    // builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
//        var miliseconds = self.rounded(.towardZero)
//        miliseconds = miliseconds.truncatingRemainder(dividingBy: 10)
        let interval = Int(self)
//        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d.%.f", hours, minutes)
    }
}
