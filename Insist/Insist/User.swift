//
//  User.swift
//  Insist
//
//  Created by Shiwei Lin on 18/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import Foundation

class User
{
    var _username: String = ""
    var _email: String = ""
    var _birthday: String = ""
    var _password: String = ""
    
    var username: String
    {
        get
        {
            return _username
        }
        set
        {
            _username = newValue
        }
    }
    
    var email: String
    {
        get
        {
            return _email
        }
        set
        {
            _email = newValue
        }
    }
    
    var birthday: String
    {
        get
        {
            return _birthday
        }
        set
        {
            _birthday = newValue
        }
    }
    
    var password: String
    {
        get
        {
            return _password
        }
        set
        {
            _password = newValue
        }
    }
    

}
