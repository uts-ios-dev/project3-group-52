//
//  WelcomeController.swift
//  Insist
//
//  Created by Shiwei Lin on 16/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class WelcomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userBirthday ])
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: view.frame.width / 4, y: view.frame.height / 2 + 120, width: view.frame.width / 2, height: 50)
        //loginButton.delegate = self
        if AccessToken.current != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton!) {
        print("Log out")
    }
    
    func loginButton(_ loginButton: LoginButton!, didCompleteWith result: LoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        print("Logged in")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
