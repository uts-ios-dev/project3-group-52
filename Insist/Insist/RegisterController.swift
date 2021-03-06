//
//  RegisterController.swift
//  Insist
//
//  Created by Shiwei Lin on 19/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

let db = Firestore.firestore()

class RegisterController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //close the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //check the register information and save the information to Firebase cloud
    @IBAction func registerButton(_ sender: Any) {
        if name.text == "" || name.text == nil || email.text == "" || email.text == nil || password.text == "" || password.text == nil
        {
            let usernameAlert = UIAlertController(title: "Empty required field", message: "Please enter all required fields", preferredStyle: .alert)
            usernameAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(usernameAlert, animated: true, completion: nil)
        }
        else {
            user.username = name.text!
            user.email = email.text!
            user.birthday = DateFormatter.localizedString(from: birthday.date, dateStyle: .medium, timeStyle: .none)
            user.password = password.text!
            Auth.auth().createUser(withEmail: user.email, password: user.password) { (authResult, error) in
                if error != nil {
                    let registerAlert = UIAlertController(title: "Can't Register", message: "Please enter valid email address and password must equal to or longer than 6 characters", preferredStyle: .alert)
                    registerAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(registerAlert, animated: true, completion: nil)
                }
                else {
                    print ("Success")
                    let settings = db.settings
                    settings.areTimestampsInSnapshotsEnabled = true
                    db.settings = settings
                    db.collection("users").document("\(user.email)").setData([
                        "name": user.username,
                        "birthday": user.birthday,
                    ]) { err in
                        if let err = err {
                            let registerAlert = UIAlertController(title: "Can't write into database", message: "\(String(describing: err))", preferredStyle: .alert)
                            registerAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action: UIAlertAction!) in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(registerAlert, animated: true, completion: nil)
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
