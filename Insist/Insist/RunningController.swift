//
//  RunningController.swift
//  Insist
//
//  Created by Shiwei Lin on 18/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import MapKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        runTimeLabel.text = "Time: 00:00:00"
        locationList.removeAll()
        distance = Measurement(value: 0, unit: UnitLength.meters)
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.activityType = .fitness
            locationManager.startUpdatingLocation()
            //locationManager.distanceFilter = 10
            map.showsUserLocation = true
        }
        distanceLabel.isHidden = true
    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        runTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        sender.isEnabled = false
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.activityType = .fitness
//            locationManager.startUpdatingLocation()
//            locationManager.distanceFilter = 10
//            map.showsUserLocation = true
//        }
        distanceLabel.isHidden = false
    }
    
    @IBAction func finishButton(_ sender: Any) {
        runTimer?.invalidate()
        record.time = runTimeLabel.text!
        if !locationList.isEmpty {
            record.startLocation = locationList.first!
            record.endLocation = locationList.last!
            locationList.removeAll()
        }
        record.distance = MeasurementFormatter().string(from: distance)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            if locationList.isEmpty {
                let location = locations.last! as CLLocation
                locationList.append(location)
            }
            else {
                if let lastLocation = locationList.last {

                    //let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                    //map.add(MKPolyline(coordinates: coordinates, count: 2))
                    let location = locations.last! as CLLocation
                    let dis = newLocation.distance(from: lastLocation)
                    distance = distance + Measurement(value: dis, unit: UnitLength.meters)
                    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    map.setRegion(region, animated: true)
                }
                locationList.append(newLocation)
                distanceLabel.text = "Distance: \(MeasurementFormatter().string(from: distance))"
            }
        }
    }
    
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
        runTimeLabel.text = "Time: \(hourString):\(minString):\(secString)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
