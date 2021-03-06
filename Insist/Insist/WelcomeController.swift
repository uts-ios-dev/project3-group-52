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
import Firebase
import FirebaseAuth
import FirebaseFirestore

var changeAccount: Bool = false

class WelcomeController: UIViewController {
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var button: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //generate facebook login button
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userBirthday ])
        loginButton.frame = button.frame
        view.addSubview(loginButton)
        self.logged()
        //check whether there is any account, if so, switch to Run view controller
        if AccessToken.current != nil || Auth.auth().currentUser != nil {
            if !changeAccount {
                self.switchToRun()
            }
        }
    }
    
    @IBAction func signupButton(_ sender: Any) {
        checkLoginStatus()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        checkLoginStatus()
    }
    
    //check whether there is any account to enter
    @IBAction func enter(_ sender: Any) {
        if AccessToken.current == nil && Auth.auth().currentUser == nil {
            let enterAlert = UIAlertController(title: "Login", message: "You must login to enter", preferredStyle: .alert)
            enterAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(enterAlert, animated: true, completion: nil)
        }
        else {
            self.logged()
        }
    }
    
    //check login status and get user information
    func logged() {
        if AccessToken.current != nil{
            UserProfile.loadCurrent { (profile) in
                if let full = UserProfile.current?.fullName {
                    user.username = full
                }
                self.getOtherInfo()
            }
            //combine Facebook login and Firebase Auth
            let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {
                    let firebaseAlert = UIAlertController(title: "Can't connected to firebase", message: "\(String(describing: error))", preferredStyle: .alert)
                    firebaseAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(firebaseAlert, animated: true, completion: nil)
                }
            }
            self.authEmailLogout()
        }
        
        //get user information from Firebase cloud
        if Auth.auth().currentUser != nil && AccessToken.current == nil {
            let emailUser = Auth.auth().currentUser
            if let emailUser = emailUser {
                user.email = emailUser.email!
                
                let settings = db.settings
                settings.areTimestampsInSnapshotsEnabled = true
                db.settings = settings
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
            }
        }
    }
    
    //check whether the user logged in
    func checkLoginStatus() {
        if AccessToken.current != nil{
            let accountAlert = UIAlertController(title: "Facebook", message: "You have logged in with Facebook", preferredStyle: .alert)
            accountAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(accountAlert, animated: true, completion: nil)
        }
        
        if Auth.auth().currentUser != nil {
            let accountAlert = UIAlertController(title: "Email", message: "You have logged in with email", preferredStyle: .alert)
            accountAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            accountAlert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action: UIAlertAction!) in
                self.authEmailLogout()
            }))
            present(accountAlert, animated: true, completion: nil)
        }
    }
    
    //switch to Run view controller
    func switchToRun() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //if the use had logged in with Email then logged in with Facebook, then logout the Email account
    func authEmailLogout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //get user Facebook information
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
    
    func loginButtonDidLogOut(_ loginButton: LoginButton!) {
        print("Log out")
    }
    
    func loginButton(_ loginButton: LoginButton!, didCompleteWith result: LoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
