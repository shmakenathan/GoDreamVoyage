//
//  WeatherViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 09/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class WeatherViewController: BaseViewController {

    
    
    @IBOutlet var newYork: [UILabel]!
    @IBOutlet var paris: [UILabel]!
    
    @IBOutlet weak var parisImageView: UIImageView!
    @IBOutlet weak var newYorkImageView: UIImageView!
    private let weatherNetworkManager = WeatherNetworkManager()
    
    
    
    func changeLabel(weatherResponse: WeatherResponseResult, cityLabel: [UILabel]){
        cityLabel[0].text = weatherResponse.weather[0].weatherDescription
        cityLabel[1].text = String(Int(round(weatherResponse.main.temp))) + "°"
        cityLabel[2].text = String(Int(round(weatherResponse.main.tempMax))) + "°"
        cityLabel[3].text = String(Int(round(weatherResponse.main.tempMin))) + "°"
        cityLabel[4].text = String(weatherResponse.main.humidity) + "%"
    }
    
    
    func loadInformationOfCities() {
        let cities = ["New York", "Paris"]
        
        changeLoadingIndicatorVisibility(shouldShow: true)
        weatherNetworkManager.fetchWeather(cities: cities, completionHandler: handleWeatherResultResponse(result:))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInformationOfCities()
     
    }
    
    func handleWeatherResultResponse(result: Result<[WeatherResponseResult], NetworkManagerError>) {
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
            case .success(let latestWeatherResult):
                self.changeLabel(weatherResponse: latestWeatherResult[0], cityLabel: self.newYork)
                self.newYorkImageView.image = UIImage(named: "\(latestWeatherResult[0].weather[0].icon)")
                self.changeLabel(weatherResponse: latestWeatherResult[1], cityLabel: self.paris)
                self.parisImageView.image = UIImage(named: "\(latestWeatherResult[1].weather[0].icon)")
           
            }
            
            self.changeLoadingIndicatorVisibility(shouldShow: false)
        }
    }
}
