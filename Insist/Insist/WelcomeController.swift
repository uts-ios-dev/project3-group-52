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
    
//    @IBOutlet weak var enter: UIButton!
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    
    @IBAction func signupButton(_ sender: Any) {
        checkLoginStatus()
    }
    @IBAction func loginButton(_ sender: Any) {
        checkLoginStatus()
    }
    
    func checkLoginStatus() {
        if AccessToken.current != nil{
            let accountAlert = UIAlertController(title: "Facebook", message: "You have logged in with Facebook ", preferredStyle: .alert)
            accountAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(accountAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userBirthday ])
        //let loginButton = LoginButton(publishPermissions: [.publishActions])
        loginButton.frame = CGRect(x: view.frame.width / 10, y: view.frame.height / 2 + 170, width: 300, height: 50)
        view.addSubview(loginButton)
//        signup.isHidden = false
//        login.isHidden = false
       // enter.isHidden = true
        //loginButton.delegate = self
        if AccessToken.current != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            navigationController?.pushViewController(vc, animated: true)
//            enter.isHidden = false
//            signup.isHidden = true
//            login.isHidden = true
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton!) {
        print("Log out")
//        signup.isHidden = false
//        login.isHidden = false
    }
    
    func loginButton(_ loginButton: LoginButton!, didCompleteWith result: LoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        print("Logged in")

//        if AccessToken.current != nil{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//            navigationController?.pushViewController(vc, animated: true)
////            enter.isHidden = false
////            signup.isHidden = true
////            login.isHidden = true
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
