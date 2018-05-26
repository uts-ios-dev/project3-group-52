//
//  ProfileController.swift
//  Insist
//
//  Created by Shiwei Lin on 17/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase
import FirebaseAuth

class ProfileController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var DOB: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AccessToken.current != nil{
            UserProfile.loadCurrent { (profile) in
                if let full = UserProfile.current?.fullName {
                    user.username = full
                }
                if let profilePictureURL = UserProfile.current?.imageURLWith(UserProfile.PictureAspectRatio.normal, size: CGSize.init()) {
                    let data = try? Data(contentsOf: profilePictureURL)
                    self.picture.image = UIImage(data: data!)
                    self.getOtherInfo()
                }
                self.printInfo()
            }
        }
        
        if Auth.auth().currentUser != nil {
            let docRef = db.collection("users").document("\(user.email)")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let mydata = document.data()
                    let latestbirthday = mydata!["birthday"] as? String ?? ""
                    user.birthday = latestbirthday
                    let latestname = mydata!["name"] as? String ?? ""
                    user.username = latestname
                } else {
                    print("Document does not exist")
                }
            }
            self.printInfo()
        }
    }
    
    func printInfo() {
        self.name.text = user.username
        self.DOB.text = user.birthday
        self.email.text = user.email
        //self.printTime()
    }
    
    func getOtherInfo() {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email, birthday"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
                if let dob = response.dictionaryValue?["birthday"] {
                    user.birthday = dob as! String
                }
                if let email = response.dictionaryValue?["email"] {
                    user.email = email as! String
                }
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
//    func printTime() {
//        let hour = user.userTime / 3600
//        let min = (user.userTime % 3600) / 60
//        let sec = (user.userTime % 3600) % 60
//
//        let secString = sec > 9 ? "\(sec)" : "0\(sec)"
//        let minString = min > 9 ? "\(min)" : "0\(min)"
//        let hourString = hour > 9 ? "\(hour)" : "0\(hour)"
//        time.text = "Total Time: \(hourString):\(minString):\(secString)"
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
