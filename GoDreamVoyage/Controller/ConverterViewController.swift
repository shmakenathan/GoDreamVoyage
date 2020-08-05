//
//  AccueilViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 13/05/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        
    }
   
    
    private func setupLoadingIndicator() {
        activityIndicatorView = UIActivityIndicatorView()
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func changeLoadingIndicatorVisibility(shouldShow: Bool) {
        if shouldShow {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

class ConverterViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var sourceSommeCurrency: UITextField!
    @IBOutlet weak var targetSommeCurrency: UITextField!
    @IBOutlet weak var sourceCurrency: UITextField!
    @IBOutlet weak var targetCurrency: UITextField!
    @IBOutlet weak var convertButton: UIButton!

    // MARK: IBAction
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sourceSommeCurrency.resignFirstResponder()
    }
    
    @IBAction func didTapOnSwitchCurrencyButton(_ sender: UIButton) {
        swap(&selectedSourceCurrencyIndex, &selectedTargetCurrencyIndex)
    }
    
    @IBAction func convert(_ sender: UIButton) {
        guard let somme = sourceSommeCurrency.text else { return }
        targetSommeCurrency.text = converterCurrency.convert(
            sommeToChange: somme,
            currencyBase: currencyTab[selectedSourceCurrencyIndex],
            currencyReturn: currencyTab[selectedTargetCurrencyIndex],
            rates: rates
        )
    }
    
    // MARK: Properties - Private
    
    private var rates: [String: Double] = [:] {
        didSet {
            if rates.count > 0 {
                changeLoadingIndicatorVisibility(shouldShow: false)
            }
        }
    }
    private var selectedSourceCurrencyIndex = 0 {
        didSet {
            sourceCurrency.text = currencyTab[selectedSourceCurrencyIndex]
        }
    }
    
    private var selectedTargetCurrencyIndex = 0 {
        didSet {
            targetCurrency.text = currencyTab[selectedTargetCurrencyIndex]
        }
    }
    
    private var currencyTab = ["USD","AUD","CAD","EUR","CHF","GBP","JPY","CNY"]
    
    private let converterCurrency = ConverterCurrency()
    private let currencyNetworkManager = CurrencyNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertButton.layer.cornerRadius = 10
        
        let myPickerSource = UIPickerView()
        myPickerSource.delegate = self
        myPickerSource.tag = 1
        sourceCurrency.inputView = myPickerSource
        selectedSourceCurrencyIndex = 0
        
        let myPickerTarget = UIPickerView()
        myPickerTarget.tag = 2
        myPickerTarget.delegate = self
        targetCurrency.inputView = myPickerTarget
        selectedTargetCurrencyIndex = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sourceSommeCurrency.addDoneButtonOnKeyboard()
        targetSommeCurrency.addDoneButtonOnKeyboard()
        changeLoadingIndicatorVisibility(shouldShow: true)
        currencyNetworkManager.fetchCurrencyConverter(completionHandler: handleCurrencyResultResponse)
    }
    
    // MARK: Methods - Private
    
    private func handleCurrencyResultResponse(result: Result<CurrencyResponseResult, NetworkManagerError>) {
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.message)
            case .success(let latestCurrencyResult):
                self.rates = latestCurrencyResult.rates
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
        switch pickerView.tag {
        case 1: selectedSourceCurrencyIndex = row
        case 2: selectedTargetCurrencyIndex = row
        default: return
        }
    }
    
}
