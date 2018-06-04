//
//  RunningController.swift
//  Insist
//
//  Created by Shiwei Lin on 18/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FacebookCore
import FacebookLogin

var user = User()
var record = Record()

class RunningController: UIViewController, CLLocationManagerDelegate {
    
    var runTime: Int = 0
    var runTimer: Timer?
    var hour: Int = 0
    var min: Int = 0
    var sec: Int = 0
    var distance: Measurement = Measurement(value: 0, unit: UnitLength.meters)
    let locationManager = CLLocationManager()
    var locationList: [CLLocation] = []
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    //get location service and show user current location
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimeLabel.text = "00:00:00"
        locationList.removeAll()
        distance = Measurement(value: 0, unit: UnitLength.meters)
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.activityType = .fitness
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        }
        distanceLabel.isHidden = true
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        locationList.removeAll()
        runTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        sender.isEnabled = false
        if CLLocationManager.locationServicesEnabled() {
            distance = Measurement(value: 0, unit: UnitLength.meters)
            //locationManager.distanceFilter = 10
            distanceLabel.isHidden = false
            distanceLabel.text = MeasurementFormatter().string(from: distance)
        }
    }
    
    //get record location, date, and time
    @IBAction func finishButton(_ sender: Any) {
        runTimer?.invalidate()
        distanceLabel.isHidden = true
        record.time = runTimeLabel.text!
        if !locationList.isEmpty {
            record.endLocation = locationList.last!
            locationList.removeAll()
        }
        record.distance = distanceLabel.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        record.date = dateFormatter.string(from: Date())
        saveData()
    }
    
    //save record information to Firebase cloud
    func saveData() {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        if Auth.auth().currentUser != nil && AccessToken.current == nil{
            db.collection("users").document("\(user.email)").collection("records").document().setData(["distance": record.distance, "time": record.time, "date": record.date])
        }
        
        if AccessToken.current != nil {
            db.collection("users").document("\(user.email)").setData([
                "name": user.username,
                "birthday": user.birthday,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
            }
            db.collection("users").document("\(user.email)").collection("records").document().setData(["distance": record.distance, "time": record.time, "date": record.date])
        }
    }
    
    //update location and distance
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            if locationList.isEmpty {
                record.startLocation = newLocation
                locationList.append(newLocation)
            }
            else {
                if let lastLocation = locationList.last {
                    let center = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    map.setRegion(region, animated: true)
                    let dis = newLocation.distance(from: lastLocation)
                    distance = distance + Measurement(value: dis, unit: UnitLength.meters)
                    locationList.append(newLocation)
                } 
                distanceLabel.text = MeasurementFormatter().string(from: distance)
            }
        }
    }
    
    //uodate time
    @objc func update() {
        sec += 1
        if sec == 60 {
            min += 1
            sec = 0
        }
        if min == 60 {
            hour += 1
            min = 0
        }
        
        let secString = sec > 9 ? "\(sec)" : "0\(sec)"
        let minString = min > 9 ? "\(min)" : "0\(min)"
        let hourString = hour > 9 ? "\(hour)" : "0\(hour)"
        runTimeLabel.text = "\(hourString):\(minString):\(secString)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
