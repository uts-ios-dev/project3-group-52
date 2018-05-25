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
    var _userTime: Int = 0
    
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
    
    var userTime: Int
    {
        get
        {
            return _userTime
        }
        set
        {
            _userTime = newValue
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
