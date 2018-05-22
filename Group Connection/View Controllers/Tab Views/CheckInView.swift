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
    
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var userView: UILabel!
    @IBOutlet weak var timeSinceLabel: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var groupMessage: UIButton!
    @IBOutlet weak var changeBuddy: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var rotation: CGFloat = 0
    var rotate = UIGestureRecognizer()
    
    var data: [Person]! = Globals.globals.user.buddyList ?? [Globals.globals.user]
    
    
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
        
        performSegue(withIdentifier: "toCheck", sender: nil)
        
    }

    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.globals.user.buddyList.count
    }
    
    
    // tells what should be displayed in each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //test this here
        let buddyCell = tableView.dequeueReusableCell(withIdentifier: "buddyCell", for: indexPath) as! BuddyTable
        print("-------------------------------------------")
        print(data[indexPath.row].fullName)
        print(Globals.globals.user.buddyList[indexPath.row].fullName)
        buddyCell.buddyName.text = data[indexPath.row].fullName
        
        
        if Globals.globals.user.buddyList[indexPath.row].checkInStatus {
            //add status pic
            
            buddyCell.statusPic.contentMode = .scaleAspectFit
        }
        else {
            //add status pic
            
            buddyCell.statusPic.clipsToBounds = true
        }
        return buddyCell
    }
    
    //delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(indexPath.row)
            print(data.count)
            //remove from the data array
            let removed = data.remove(at: indexPath.row)
            
            //remove from the student list
            let int = Globals.globals.user.buddyList.index(of: removed)
            Globals.globals.user.buddyList.remove(at: int!)
            
            //remove from the physical table
            table.deleteRows(at: [indexPath], with: .automatic)
            table.reloadData()
            table.endUpdates()
        }
    }
    
    //set which rows can be edited
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    @IBAction func changeBuddies(_ sender: Any) {
        performSegue(withIdentifier: "ToBuddyRoster", sender: nil)
    }
    
    private func panic() {
        //stub
        do {
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

    private func constrain() {
        print("constraining check in view ------------------------")
        changeBuddy.snp.makeConstraints { (snap) -> Void in
            print(changeBuddy.frame.maxY)
//            snap.bottom.equalTo(self.view.snp.bottomMargin)//view.snp.bottomMargin)
//            print(changeBuddy.frame.maxY)
//            snap.centerX.equalTo(self.view.snp.centerX)
        }

        table.snp.makeConstraints { (snap) -> Void in
            //            snap.height.equalTo(159)
            //            snap.centerX.equalTo(self.view.snp.centerX)
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
        
        if Globals.globals.user.buddyList.count < 2 {
            changeBuddy.titleLabel?.text = "Add Buddy"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


