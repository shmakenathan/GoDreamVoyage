//
//  AccueilViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 13/05/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    
    @IBOutlet weak var sourceSommeCurrency: UITextField!
    @IBOutlet weak var targetSommeCurrency: UITextField!
    
    @IBOutlet weak var sourceCurrency: UITextField!
    @IBOutlet weak var targetCurrency: UITextField!
    
    @IBAction func didTapOnLoadButton(_ sender: UIButton) {
        let urlString = "http://data.fixer.io/api/latest?access_key=aaa3bb4285d0f3ba1bcda2fc1926c039"
        guard let url = URL(string: urlString) else { return }
        networkManager.fetchResult(url: url, completionHandler: handleCurrencyResultResponse)
        
    }
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myPickerSource = UIPickerView()
        myPickerSource.delegate = self
        sourceCurrency.inputView = myPickerSource
        
        let myPickerTarget = UIPickerView()
        myPickerTarget.delegate = self
        targetCurrency.inputView = myPickerTarget
    }
    var rates: [String: Double] = ["": 0]
    var currencyTab = ["USD","AUD","CAD","EUR","CHF","GBP","JPY","CNY"]
    
    func createe(tab1: [String: Double],tab2: [String]) -> [String: Double] {
        var tab: [String: Double] = ["": 0]
        for i in tab2 {
            for (cle, valeur) in tab1 where i == cle {
                tab[cle] = valeur
            }
            tab.removeValue(forKey: "")
        }
        return tab
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
    func handleCurrencyResultResponse(result: Result<LatestCurrencyResult, NetworkManagerError>) {
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
                self.sourceCurrency.text = error.localizedDescription
            case .success(let latestCurrencyResult):
                
                self.rates = latestCurrencyResult.rates
                /*  self.ratescurr = self.createTab()
                 self.rates = self.createe(tab1: self.rates, tab2: self.ratescurr)*/
                
            }
            
        }
    }
    
}
extension ConverterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Currency.allCases[row].title
        
    }
}
extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Currency.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sourceCurrency.text = currencyTab[row]
        targetCurrency.text = currencyTab[row]
    }
    
}
