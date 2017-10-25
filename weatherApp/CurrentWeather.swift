//
//  CurrentWeather.swift
//  weatherApp
//
//  Created by Alex Gain on 10/10/17.
//  Copyright © 2017 Alex Gain. All rights reserved.
//

import UIKit
import Alamofire

typealias DownloadComplete = () -> ()

class currentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    var _hiTemp: Double!
    var _lowTemp: Double!
    var _day: String!

    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "\(currentDate)"
        return _date
    }
    
    var day: String {
        if _day == nil {
            _day = ""}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let currentDay = dateFormatter.string(from: Date()).capitalized
        self._day = "\(currentDay)"
        return _day
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""}
        return _weatherType
    }

    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0}
        return _currentTemp
    }
    
    var hiTemp: Double {
        if _hiTemp == nil {
            _hiTemp = 0.0}
        return _hiTemp
    }

    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0}
        return _lowTemp
        
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {

        Alamofire.request(weatherURL).responseJSON { response in
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
            
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        self._currentTemp = currentTemperature
                    }
                }
        
            }

        completed()
    }
    
    }

}







