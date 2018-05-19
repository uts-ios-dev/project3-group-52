//
//  RegisterController.swift
//  Insist
//
//  Created by Shiwei Lin on 19/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import FacebookCore

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
            user.birthday = birthday.date
            user.password = password.text!
//            print(user.username)
//            print(user.email)
//            print(user.birthday)
//            print(user.password)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
