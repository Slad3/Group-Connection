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
import SnapKit

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
    @IBOutlet weak var temp: UILabel!
    
    var rotation: CGFloat = 0
    var rotate = UIRotationGestureRecognizer()
    
    var textBox: UITextField!
    
    var data: [Person]! = Globals.globals.user.studentList 
    
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
        
        //asshattery 
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
        performSegue(withIdentifier: "toMentorRoster", sender: nil)
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
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    // tells what should be displayed in each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //test this here
        let buddyCell = tableView.dequeueReusableCell(withIdentifier: "buddyCell", for: indexPath) as! BuddyTable
        
        buddyCell.buddyName.text = Globals.globals.user.studentList[indexPath.row].fullName
//        
//        
//        if Globals.globals.user.studentList[indexPath.row].checkInStatus {
//            //change for obvious reasons
//            buddyCell.statusPic.image = UIImage(named: "obama.jpg_large")
//            //--------------------------
//            
//            buddyCell.statusPic.contentMode = .scaleAspectFit
//        }
//        else {
//            //change for obvious reasons (again)
//            let chosenImage = UIImage(named: "zucc.jpg")
//            //-------------------------
//            
//            buddyCell.statusPic.image = chosenImage
//            buddyCell.statusPic.clipsToBounds = true
//        }
        return buddyCell
    }
    
    //delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("deleting")
            //remove from the data array
            let removed = data.remove(at: indexPath.row)
            
            //remove from the student list
            let int = Globals.globals.user.studentList.index(of: removed)
            Globals.globals.user.studentList.remove(at: int!)
            
            //remove from the physical table
            table.deleteRows(at: [indexPath], with: .automatic)
            table.reloadData()
        }
    }
    
    //set which rows can be edited
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
        
        if Globals.globals.user.studentList.count < 2 {
            changeBuddy.titleLabel?.text = "Add Student"
        }
        
        if Globals.globals.event != nil {
            accessCode.text = Globals.globals.event.generalAccessCode
        }
        else {
            accessCode.text = "Here's your code, Ben"
        }
        
        constrain()
    }
    
    private func constrain() {
        print("constraining mentor view ------------------------")
        changeBuddy.snp.makeConstraints { (snap) -> Void in
            print(changeBuddy.frame.maxY)
            snap.bottom.equalTo(self.view.snp.bottomMargin)//view.snp.bottomMargin)
            print(changeBuddy.frame.maxY)
            snap.centerX.equalTo(self.view.snp.centerX)
        }

        table.snp.makeConstraints { (snap) -> Void in
//            snap.height.equalTo(159)
//            snap.centerX.equalTo(self.view.snp.centerX)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //lower any keyboards when the user taps anywhere besides a text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func doStuff() {
        temp.text = ""
        print("ran")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(doStuff), userInfo: nil, repeats: false)
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
