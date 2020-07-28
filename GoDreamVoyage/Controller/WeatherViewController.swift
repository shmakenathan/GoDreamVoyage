//
//  WeatherViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 09/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class WeatherViewController: BaseViewController {
    
    @IBOutlet weak var newYorkImage: UIImageView!
    @IBOutlet weak var newYorkTemperatureLabel: UILabel!
    @IBOutlet weak var newYorkClimatLabel: UILabel!
    
    
    @IBOutlet weak var parisClimatLabel: UILabel!
    @IBOutlet weak var parisTemperatureLabel: UILabel!
    @IBOutlet weak var parisImage: UIImageView!
    
    
    
    private let weatherNetworkManager = WeatherNetworkManager()
    
    
    
    
    
    
    func loadInformationOfCities() {
        let cities = ["Paris","New York"]
        
        weatherNetworkManager.fetchWeather(cities: cities, completionHandler: handleWeatherResultResponse(result:))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLoadingIndicatorVisibility(shouldShow: true)
        loadInformationOfCities()
     
    }
    func setImage(from url: String, imageView: UIImageView) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    func handleWeatherResultResponse(result: Result<[WeatherResponseResult], NetworkManagerError>) {
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
            case .success(let latestWeatherResult):
                self.setImage(from: "http://openweathermap.org/img/wn/\(latestWeatherResult[1].weather[0].icon)@2x.png", imageView: self.newYorkImage)
                
                }
            
        }
    }
}
