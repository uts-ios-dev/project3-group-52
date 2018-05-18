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
    @IBOutlet weak var rePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
