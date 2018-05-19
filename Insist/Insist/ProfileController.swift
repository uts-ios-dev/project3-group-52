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

class ProfileController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var DOB: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AccessToken.current != nil{
            UserProfile.loadCurrent { (profile) in
                if let full = UserProfile.current?.fullName {
                    self.name.text = "Name: \(full)"
                }
                if let profilePictureURL = UserProfile.current?.imageURLWith(UserProfile.PictureAspectRatio.normal, size: CGSize.init()) {
                    let data = try? Data(contentsOf: profilePictureURL)
                    self.picture.image = UIImage(data: data!)
                }
                self.getOtherInfo()
            }
        }
        else {
            if user.email != "" {
                self.name.text = "Name: \(user.username)"
                self.DOB.text = "Birthday: \(DateFormatter.localizedString(from: user.birthday, dateStyle: .medium, timeStyle: .none))"
                self.email.text = "Email: \(user.email)"
            }
        }
    }
    
    func getOtherInfo() {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email, birthday"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
                if let dob = response.dictionaryValue?["birthday"] {
                    self.DOB.text = "Birthday: \(dob)"
                }
                if let email = response.dictionaryValue?["email"] {
                    self.email.text = "Email: \(email)"
                }
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
