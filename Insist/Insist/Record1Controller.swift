//
//  RecordController.swift
//  Insist
//
//  Created by Shiwei Lin on 26/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Record1Controller: UITableViewController {
//    var latestTime:String = ""
//    var latestDistance:String = ""
//    var count:Int = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int
//    {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        var userRecord = [String: Any]()
//        var userRecords = Array[Any]
//        let settings = db.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        db.settings = settings
//        db.collection("users").document("\(user.email)").collection("records").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    userRecord = document.data()
//                    self.latestTime = userRecords["time"] as? String ?? ""
//                    self.latestDistance = userRecords["distance"] as? String ?? ""
//                    print(self.latestTime)
//                    print(self.latestDistance)
//                    self.count += 1
//                    print(self.count)
//                    userRecords.append(userRecord)
//                }
//            }
//        }
//
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//        let record = userRecords[indexPath.row]
//        cell.textLabel?.text = latestDistance
//        cell.detailTextLabel?.text = latestTime
//        cell.detailTextLabel?.textColor = UIColor.blue
//        return cell
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
}
