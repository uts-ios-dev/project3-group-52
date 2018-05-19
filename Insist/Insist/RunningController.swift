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
    
//    var startTime: Int = 3
//    var startTimer: Timer?
    var runTime: Int = 0
    var runTimer: Timer?
    var hour: Int = 0
    var min: Int = 0
    var sec: Int = 0
    var distance: Measurement = Measurement(value: 0, unit: UnitLength.meters)

    let locationManager = CLLocationManager()
    var locationList: [CLLocation] = []
    
   // var startStopWatch: Bool = false
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var runTimeLabel: UILabel!
<<<<<<< HEAD
    @IBOutlet weak var distanceLabel: UILabel!
  //  @IBOutlet weak var speedLabel: UILabel!
    //  @IBOutlet weak var startLabel: UILabel!
    
    @IBAction func startButton(_ sender: UIButton) {
//        if startStopWatch == false {

        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
=======
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var pause: UIButton!
    @IBAction func pauseButton(_ sender: Any) {
        if startStopWatch == true {
            runTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            startStopWatch = false
            pause.setTitle("Pause", for: .normal)
        }
        else {
            startStopWatch = true
            runTimer?.invalidate()
            pause.setTitle("Continue", for: .normal)
>>>>>>> bcdd5ca9f03602f1f305cfe3f52d5bf99f198355
        }
 
        runTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        sender.isEnabled = false
        
       // record.startLocation =
//            startStopWatch = true
//            pause.setTitle("Pause", for: .normal)
//        }
//        else {
//            startStopWatch = false
//            runTimer?.invalidate()
//            pause.setTitle("Continue", for: .normal)
//        }
    }

    @IBAction func finishButton(_ sender: Any) {
        runTimer?.invalidate()
        record.time = runTimeLabel.text!
        print(record.time)
        if !locationList.isEmpty {
            record.startLocation = locationList[0]
            record.endLocation = locationList.last!
            locationList.removeAll()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.

        // Do any additional setup after loading the view, typically from a nib.
        runTimeLabel.text = "Time: 00:00:00"
        if !locationList.isEmpty {
            locationList.removeAll()
        }
        //pause.setTitle("Start", for: .normal)
//        startLabel.text = String(startTime)
//        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.start), userInfo: nil, repeats: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
<<<<<<< HEAD
=======
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        record.startLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
>>>>>>> bcdd5ca9f03602f1f305cfe3f52d5bf99f198355
        
      //  let location = locations.last! as CLLocation
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        self.map.setRegion(region, animated: true)
//        locationList.append(location)

        
        for newLocation in locations {
//            let howRecent = newLocation.timestamp.timeIntervalSinceNow
//            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if locationList.isEmpty {
                let location = locations.last! as CLLocation
                locationList.append(location)
            }
            else {
                if let lastLocation = locationList.last {
                    let dis = newLocation.distance(from: lastLocation)
                    print(dis)
                    //speedLabel.text = "Speed: \(round(dis/Double((60*sec))))"
                    distance = distance + Measurement(value: dis, unit: UnitLength.meters)
                    let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                    map.add(MKPolyline(coordinates: coordinates, count: 2))
                    let location = locations.last! as CLLocation
                    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    map.setRegion(region, animated: true)
                }
                locationList.append(newLocation)
                distanceLabel.text = "Distance: \(MeasurementFormatter().string(from: distance))"
                //
//                if let dist = Int(dis) {
//                    //distanceLabel.text = "Distance: \(dist)"
//                    speedLabel.text = "Speed: \(dist/(60*sec))"
//                }
            }
        }
//        print("Startlocation:\(record.startLocation)")
    }
//    @objc func start() {
//        startTime = startTime - 1
//        startLabel.text = String(startTime)
//        if (startTime == 0) {
//            startLabel.isHidden = true
//            startTimer?.invalidate()
//        }
//    }
    
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
