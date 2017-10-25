//
//  forecast.swift
//  weatherApp
//
//  Created by Alex Gain on 10/16/17.
//  Copyright © 2017 Alex Gain. All rights reserved.
//

import UIKit
import Alamofire


class forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    var Forecasts = [forecast]()
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>){
        if let temp = weatherDict["main"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["temp_min"] as? Double {
                self._lowTemp = "\(min)"
                }
            
            if let max = temp["temp_max"] as? Double {
                self._highTemp = "\(max)"
            }
            }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let type = weather[0]["main"] as? String {
                self._weatherType = type.capitalized
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
    func  downloadForecastData(completed: @escaping DownloadComplete) {
        let CurrentWeather = currentWeather()
        var date = CurrentWeather.day
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast1 = forecast(weatherDict: obj)
                          if forecast1._date != date {
                          self.Forecasts.append(forecast1)
                          date = forecast1._date
                        }
                        
                       
                    }
                }

            }
            print(self.Forecasts)
            completed()
        
        }
    }
 
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
        }
}


