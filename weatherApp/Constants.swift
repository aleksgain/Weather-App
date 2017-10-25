//
//  Constants.swift
//  weatherApp
//
//  Created by Alex Gain on 10/10/17.
//  Copyright © 2017 Alex Gain. All rights reserved.
//

import Foundation

var latitude = ""

var longitude = ""

let apiKey = "fe1a4cd7136a644f0306a50d96846372"

var weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=Imperial&appid=\(apiKey)"

let imperialWeatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=Imperial&appid=\(apiKey)"

let metricWeatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=Metric&appid=\(apiKey)"

var forecastURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=Imperial&appid=\(apiKey)"

let imperialForecastURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=Imperial&appid=\(apiKey)"

let metricForecastURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=Metric&appid=\(apiKey)"
