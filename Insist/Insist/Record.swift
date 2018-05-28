//
//  Record.swift
//  Insist
//
//  Created by Shiwei Lin on 18/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import Foundation
import MapKit

class Record
{
    var _startLocation: CLLocation = CLLocation.init()
    var _endLocation: CLLocation = CLLocation.init()
    var _time: String = ""
    var _distance: String = ""
    var _date: String = ""
    
    var startLocation: CLLocation
    {
        get
        {
            return _startLocation
        }
        set
        {
            _startLocation = newValue
        }
    }

    var endLocation: CLLocation
    {
        get
        {
            return _endLocation
        }
        set
        {
            _endLocation = newValue
        }
    }
    
    var time: String
    {
        get
        {
            return _time
        }
        set
        {
            _time = newValue
        }
    }
    
    var distance: String
    {
        get
        {
            return _distance
        }
        set
        {
            _distance = newValue
        }
    }
    
    var date: String
    {
        get
        {
            return _date
        }
        set
        {
            _date = newValue
        }
    }
}
