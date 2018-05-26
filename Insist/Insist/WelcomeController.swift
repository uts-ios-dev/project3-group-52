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

class WelcomeController: UIViewController {
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userBirthday ])
        loginButton.frame = CGRect(x: view.frame.width / 10, y: view.frame.height / 2 + 170, width: 300, height: 50)
        view.addSubview(loginButton)
        
        if AccessToken.current != nil{
            UserProfile.loadCurrent { (profile) in
                if let full = UserProfile.current?.fullName {
                    user.username = full
                }
                self.getOtherInfo()
            }
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
            self.switchToRun()
        }
        
        if Auth.auth().currentUser != nil {
            let emailUser = Auth.auth().currentUser
            if let emailUser = emailUser {
                user.email = emailUser.email!
                let docRef = db.collection("users").document("\(user.email)")
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        let mydata = document.data()
                        let latestbirthday = mydata!["birthday"] as? String ?? ""
                        user.birthday = latestbirthday
                        let latestname = mydata!["name"] as? String ?? ""
                        user.username = latestname
                    } else {
                        print("Document does not exist")
                    }
                }

                db.collection("users").document("\(user.email)").collection("records").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                        }
                    }
                }
            }
            self.switchToRun()
        }
    }
    
    @IBAction func signupButton(_ sender: Any) {
        checkLoginStatus()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        checkLoginStatus()
    }
    
    @IBAction func enter(_ sender: Any) {
        if AccessToken.current == nil && Auth.auth().currentUser == nil {
            let enterAlert = UIAlertController(title: "Login", message: "You must login to enter", preferredStyle: .alert)
            enterAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(enterAlert, animated: true, completion: nil)
        }
    }
    
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
                self.authLogout()
            }))
            present(accountAlert, animated: true, completion: nil)
        }
    }
    
    func switchToRun() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func authLogout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
