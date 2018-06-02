//
//  RecordController.swift
//  Insist
//
//  Created by Shiwei Lin on 26/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FacebookCore
import UIKit

class RecordController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil || AccessToken.current != nil {
            showRecord()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var recordsString = Array<String>()
    
    //get the record from Firebase cloud and order them by distance
    func showRecord() {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        db.collection("users").document("\(user.email)").collection("records").order(by: "distance", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let userRecords = document.data()
                    let latestTime = userRecords["time"] as? String ?? ""
                    let latestDistance = userRecords["distance"] as? String ?? ""
                    let latestDate = userRecords["date"] as? String ?? ""
                    let recordString = "🗓 " + latestDate + " ⏱ " + latestTime + " 🏃🏻 " + latestDistance
                    self.recordsString.append(recordString)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return recordsString.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = recordsString[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

