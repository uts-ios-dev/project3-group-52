//
//  RecordController.swift
//  Insist
//
//  Created by Shiwei Lin on 26/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import Firebase
import FirebaseFirestore
import UIKit

class RecordController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var Ly:Int = 0
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        db.collection("users").document("\(user.email)").collection("records").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var recordLabel: UILabel
                    print("\(document.documentID) => \(document.data())")
                    let userRecords = document.data()
                    let latestTime = userRecords["time"] as? String ?? ""
                    let latestDistance = userRecords["distance"] as? String ?? ""
                    recordLabel = UILabel()
                    recordLabel.text = latestTime + "           " + latestDistance
                    recordLabel.sizeToFit()
                    recordLabel.frame = CGRect(x: Int(self.view.frame.width / 4), y: Ly, width: 400, height: 20)
                    self.view.addSubview(recordLabel)
                    //print(latestTime)
                    //print(latestDistance)
                    Ly += 30
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

