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
    
    
    
    private let networkManager = NetworkManager()
    
    
    func loadInformationCity(weatherResponse: WeatherResponseResult) {
        
        
    }
    
    
    
    
    @IBAction func didTapOnLoadButton(_ sender: UIButton) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=0a3e463e85b227d34e2fc8815539ff20"
        guard let url = URL(string: urlString) else { return }
        networkManager.fetchResult(url: url, completionHandler: handleWeatherResultResponse)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLoadingIndicatorVisibility(shouldShow: true)
        
     
    }
    func handleWeatherResultResponse(result: Result<WeatherResponseResult, NetworkManagerError>) {
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
            //self.ratesLabel.text = error.localizedDescription
            case .success(let latestWeatherResult):
                print("Received the data and now we will display it \(latestWeatherResult.name)")
                
                
                
                //self.ratesLabel.text = ratesString
            }
            
        }
    }
}
