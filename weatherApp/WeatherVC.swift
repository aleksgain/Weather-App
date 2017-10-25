//
//  WeatherVC.swift
//  weatherApp
//
//  Created by Alex Gain on 10/4/17.
//  Copyright © 2017 Alex Gain. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var unitSelector: UISegmentedControl!
    
    let refreshControl = UIRefreshControl()
    let locationManager = CLLocationManager()
    var timer = Timer()
    var currentLocation: CLLocation!
    var CurrentWeather: currentWeather!
    var Forecast: forecast!

  override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
    
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(refreshData(_:)), userInfo: nil, repeats: true)
        loadData()
    }

    
    @IBAction func unitSelected(_ sender: UISegmentedControl) {
        
        switch unitSelector.selectedSegmentIndex {
            
        case 0:
            weatherURL = imperialWeatherURL;
            forecastURL = imperialForecastURL;
        case 1:
            weatherURL = metricWeatherURL;
            forecastURL = metricForecastURL;
        default:
            weatherURL = imperialWeatherURL;
            forecastURL = imperialForecastURL;
        }
  
        loadData()
        
    }
    
    
    @IBAction func weatherRefresh(_ sender: Any) {
        loadData()
  
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Forecast.Forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = Forecast.Forecasts[indexPath.row]
            cell.configureCell(Forecast: forecast)
            tableView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
            return cell
        } else {
            return WeatherCell()
        }
        
    }

    @objc private func refreshData(_ sender: Any){
        loadData()
        refreshControl.endRefreshing()
    }
    
    func loadData() {
        CurrentWeather = currentWeather()
        Forecast = forecast(weatherDict: [:])
        locationAuthStatus()
        self.CurrentWeather.downloadWeatherDetails {
        self.Forecast.downloadForecastData {
                self.tableView.reloadData()
                self.updateMainUI()
                }
    }
    }

    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
           currentLocation = locationManager.location
            latitude = "\(currentLocation.coordinate.latitude)"
            longitude = "\(currentLocation.coordinate.longitude)"
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = CurrentWeather.date
        dayLabel.text = CurrentWeather.day
        currentTempLabel.text = "\(CurrentWeather.currentTemp)°"
        locationLabel.text = CurrentWeather.cityName
        currentWeatherType.text = CurrentWeather.weatherType
        currentWeatherImage.image = UIImage(named: CurrentWeather.weatherType)
    }
}

