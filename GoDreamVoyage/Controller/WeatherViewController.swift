//
//  WeatherViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 09/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    @IBAction func didTapOnLoadButton(_ sender: UIButton) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=0a3e463e85b227d34e2fc8815539ff20"
        guard let url = URL(string: urlString) else { return }
        networkManager.fetchResult(url: url, completionHandler: handleWeatherResultResponse)
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
