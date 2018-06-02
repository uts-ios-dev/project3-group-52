//
//  LoginController.swift
//  Insist
//
//  Created by Shiwei Lin on 19/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //login by Email
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (result, error) in
            if error != nil {
                let loginAlert = UIAlertController(title: "Can't login", message: "Your password or email address is incorrect", preferredStyle: .alert)
                loginAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action: UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(loginAlert, animated: true, completion: nil)
            }
            else {
                let emailUser = Auth.auth().currentUser
                if let emailUser = emailUser {
                    user.email = emailUser.email!
                    
                    let settings = db.settings
                    settings.areTimestampsInSnapshotsEnabled = true
                    db.settings = settings
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
                }
                print ("Success")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
