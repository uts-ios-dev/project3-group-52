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
    var _birthday: Date = Date.init()
    var _password: String = ""
    var _totaldistance: Int = 0
    var _userTime: String = ""
    
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
    
    var totaldistance: Int
    {
        get
        {
            return _totaldistance
        }
        set
        {
            _totaldistance = newValue
        }
    }
    
    var userTime: String
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
    
    var birthday: Date
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
}
