//
//  WeatherCell.swift
//  weatherApp
//
//  Created by Alex Gain on 10/18/17.
//  Copyright © 2017 Alex Gain. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {


    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDay: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherHigh: UILabel!
    @IBOutlet weak var weatherLow: UILabel!
    
    func configureCell(Forecast: forecast) {
        weatherIcon.image = UIImage(named: Forecast.weatherType)
        weatherDay.text = "\(Forecast.date)"
        weatherType.text = "\(Forecast.weatherType)"
        weatherHigh.text = "\(Forecast.highTemp)°"
        weatherLow.text = "\(Forecast.lowTemp)°"
    }
}
