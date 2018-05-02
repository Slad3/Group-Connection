//
//  CheckView.swift
//  Group Connection
//
//  Created by NARANJO, DANIEL on 4/12/18.
//  Copyright © 2018 District196. All rights reserved.
// ------------------------IQKEYBOARD MANAGER

import Foundation
import UIKit
import MapKit

class SendCheck: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var messageBox: UITextView!
    
    var data: [Person] = Globals.globals.user.buddyList
    var check: Check!
    
    var checkingIn: [Person] = [Globals.globals.user]
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 500 //displayed region size = 0.5 km
    
    @IBAction func cancel(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: nil)
    }
    
    @IBAction func finish(_ sender: Any) {
        //stub
        
        let place = locationManager.location ?? CLLocation()
        let description = messageBox.text ?? "default"
        let mentor = Globals.globals.user.mentor ?? Person()
        
        print("who checking in")
        
        if let selectedIndexes = table.indexPathsForSelectedRows {
            for i in selectedIndexes {
                checkingIn.append(Globals.globals.user.buddyList[i.row])
            }
        }
        
        for person in checkingIn {
            print(person.firstName)
            let check = Check.init(sender: person, place: place, description: description)
            print(check.coordinate)
            check.sendThisCheck(to: mentor)
            print(mentor.firstName)
        }
        
        performSegue(withIdentifier: "back", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.allowsMultipleSelection = true
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse {
            //if they haven't given permission already
            locationManager.requestWhenInUseAuthorization()
        }
        
        startReceivingLocationChanges()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.checkingIn = []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buddyCell", for: indexPath) as! BuddyTable
        cell.buddyName.text = data[indexPath.row].fullName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .purple
    }
    
    //started editing additionalNotes
    func textViewDidBeginEditing(_ textView: UITextView) {
        messageBox.text = ""
    }
    
    func startReceivingLocationChanges(){
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus != .authorizedWhenInUse {
            //user hasn't authorized location
            return
        }
        if !CLLocationManager.locationServicesEnabled() {
            //location services aren't available
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5.0 //5 meters until update
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        _ = locations.last
        
        //do something with this location
    }
    
    
}
