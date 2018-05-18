//
//  RunningController.swift
//  Insist
//
//  Created by Shiwei Lin on 18/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit

var user = User()
var record = Record()

class RunningController: UIViewController {
    
//    var startTime: Int = 3
//    var startTimer: Timer?
    var runTime: Int = 0
    var runTimer: Timer?
    var hour: Int = 0
    var min: Int = 0
    var sec: Int = 0
    
    var startStopWatch: Bool = true
    
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
        // Do any additional setup after loading the view, typically from a nib.
        runTimeLabel.text = "00:00:00"
        pause.setTitle("Start", for: .normal)
//        startLabel.text = String(startTime)
//        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.start), userInfo: nil, repeats: true)
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
