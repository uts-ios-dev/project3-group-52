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
    let locationManager = CLLocationManager()
    
    var startStopWatch: Bool = true
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var runTimeLabel: UILabel!
  //  @IBOutlet weak var startLabel: UILabel!
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
        }
    }

    @IBAction func finishButton(_ sender: Any) {
        runTimer?.invalidate()
        record.time = runTimeLabel.text!
        print(record.time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        }
        // Do any additional setup after loading the view, typically from a nib.
        runTimeLabel.text = "00:00:00"
        pause.setTitle("Start", for: .normal)
//        startLabel.text = String(startTime)
//        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.start), userInfo: nil, repeats: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
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
        runTimeLabel.text = "\(hourString):\(minString):\(secString)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
