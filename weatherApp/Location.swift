//
//  Location.swift
//  weatherApp
//
//  Created by Alex Gain on 10/20/17.
//  Copyright © 2017 Alex Gain. All rights reserved.
//

import CoreLocation

class Location {
   
    static var sharedInstance = Location()
    
    private init() {
            }
    
    var latitude: Double!
    var longitude: Double!
    
}
