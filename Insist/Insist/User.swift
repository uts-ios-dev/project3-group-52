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
    var _totaldistance: Int = 0
    var _email: String = ""
    var _userTime: Timer = Timer.init()
    
    
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
    
    var userTime: Timer
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
}
