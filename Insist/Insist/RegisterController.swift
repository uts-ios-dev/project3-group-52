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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if name.text == "" || name.text == nil || email.text == "" || email.text == nil || password.text == "" || password.text == nil
        {
            let usernameAlert = UIAlertController(title: "Empty required field", message: "Please enter all required fields", preferredStyle: .alert)
            usernameAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(usernameAlert, animated: true, completion: nil)
        }
        else
        {
            user.username = name.text!
            user.email = email.text!
            user.birthday = DateFormatter.localizedString(from: birthday.date, dateStyle: .medium, timeStyle: .none)
            user.password = password.text!
            Auth.auth().createUser(withEmail: user.email, password: user.password) { (authResult, error) in
                if error != nil {
                    let registerAlert = UIAlertController(title: "Can't Register", message: "Please enter the valid email address and your password must be 6 characters long or more", preferredStyle: .alert)
                    registerAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(registerAlert, animated: true, completion: nil)
                    //print (error)
                }
                else {
                    print ("Success")
                    
                    db.collection("users").document("\(user.email)").setData([
                        "name": user.username,
                        "birthday": user.birthday,
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    
//                    var ref: DocumentReference? = nil;
//                    ref = db.collection("users").addDocument(data: [
//                        "name": user.username,
//                        "birthday": user.birthday,
//                    ]) { err in
//                        if let err = err {
//                            print("Error adding document: \(err)")
//                        } else {
//                            print("Document added with ID: \(ref!.documentID)")
//                        }
//                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
