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
        // Do any additional setup after loading the view, typically from a nib.
        if AccessToken.current != nil{
            UserProfile.loadCurrent { (profile) in
                if let full = UserProfile.current?.fullName {
                    self.name.text = "Name: \(full)"
                }
                if let profilePictureURL = UserProfile.current?.imageURLWith(UserProfile.PictureAspectRatio.normal, size: CGSize.init()) {
                    let data = try? Data(contentsOf: profilePictureURL)
                    self.picture.image = UIImage(data: data!)
                }
                
//                let req = GraphRequest(graphPath: "me", parameters: ["fields":"email, userBirthday"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
//                req.start({ (connection, result) in
//                        print("result\(result)")
//                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
