//
//  MapView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
import MapKit

class MapView: Sub, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var importMap: UIImageView!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 500 //displayed region size = 0.5 km
    
    var whatView = 1
    
    @objc private func swapMaps(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            whatView = -whatView
            if whatView < 0 {
                view.bringSubview(toFront: importMap)
            }
            else {
                view.bringSubview(toFront: mapView)
            }
        }
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
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkForIns() {
        //mentor-side only. looks to see if any check ins have gotten been sent to them
        print("user.isMentor = \(String(describing: Globals.globals.user?.isMentor))")
        let mentor: Bool = (Globals.globals.user?.isMentor)!
        print("mentor = \(mentor)")
        let hasCheck: Bool = (Globals.globals.user?.hasCheckIn)!
        print("user.hasCheckIn = \(Globals.globals.user.hasCheckIn)")
        print("hasCheck = \(hasCheck)")
        
        if mentor {
            if hasCheck {
                for check in Globals.globals.user.checkArray {
                    //for each check waiting, make annotation on the map
                    mapView.addAnnotation(check)
                    print("Check \(check.sender.firstName) annotated")
                }
            }
        }
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse {
            //if they haven't given permission already
            locationManager.requestWhenInUseAuthorization()
        }
        
        startReceivingLocationChanges()
        
        let initialLocation = locationManager.location
        mapView.showsUserLocation = true
        centerMapOnLocation(location: initialLocation ?? CLLocation(latitude: 44.821152, longitude: -93.120435))
        
        importMap.image = UIImage(data: Globals.globals.compressedMap)
        
        let presser = UILongPressGestureRecognizer(target: self, action: #selector(swapMaps(_:)))
        presser.minimumPressDuration = 0.33
        view.addGestureRecognizer(presser)
        view.bringSubview(toFront: mapView)
        view.bringSubview(toFront: tempLabel)
        
        checkForIns()
    }
    

    
    @objc func doStuff() {
        tempLabel.text = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(doStuff), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
}


