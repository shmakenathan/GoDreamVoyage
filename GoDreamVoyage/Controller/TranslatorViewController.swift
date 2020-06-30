//
//  TranslatorViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 16/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if
            let languageListViewController = segue.destination as? LanguageListViewController,
            let senderButton = sender as? UIButton {
            languageListViewController.isSourceLanguageSelection = senderButton.tag == 0
            languageListViewController.delegate = self
        }
    }
    
    @IBOutlet weak var sourceLanguageButton: UIButton!
    @IBOutlet weak var targetLanguageButton: UIButton!
    
    @IBOutlet weak var targetLanguageLabel: UILabel!
    
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    
    
    
    var sourceLanguage = Language.French {
        didSet {
            sourceLanguageButton.setTitle(sourceLanguage.title, for: .normal)
            sourceLanguageLabel.text = sourceLanguage.title
            
        }
    }
    
    var targetLanguage = Language.English {
        didSet {
            targetLanguageButton.setTitle(targetLanguage.title, for: .normal)
            targetLanguageLabel.text = targetLanguage.title
        }
    }
    
    
    
    @IBAction func converter(_ sender: UIButton) {
        guard let textToTranslate = textTotranslate.text else {
            print("notext")
            return
        }
        
        let urlString = networkManager.createUrl(baseLanguage: sourceLanguage.initial, returnLanguage: targetLanguage.initial, textToTranslate: textToTranslate)
        guard let url = URL(string: urlString) else {
            print("erreur")
            return }
        networkManager.fetchResult(url: url, completionHandler: handleTranslationResultResponse)
        
    }
    
    private let networkManager = TranslatorNetworkManager()
    
  /*  func createUrl(baseLanguage : String, returnLanguage : String, textToTranslate : String) -> String? {
        // TODO: Move function into its own service like "TranslatorNetworkManager"
        // TODO: Use URLComponent to create the url instead of appending string
        // TODO: Use add percent encoding for string to url
        let key = "AIzaSyC4ScTYcgRiAY9NQ8TzTJkt1cFzvL6dg4k"
        let format = "text"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "source", value: baseLanguage),
            URLQueryItem(name: "target", value: returnLanguage),
            URLQueryItem(name: "q", value: textToTranslate),
            URLQueryItem(name: "format", value: format)
        ]
        
        return urlComponents.string
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourceLanguage = Language.French
        targetLanguage = Language.English
    }
    
    @IBOutlet weak var textTotranslate: UITextView!
    @IBOutlet weak var textTranslate: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
    func handleTranslationResultResponse(result: Result<TranslateResponseResult, NetworkManagerError>) {
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
                self.textTranslate.text = error.localizedDescription
            case .success(let latestTranslateResult):
                print("Received the data and now we will display it \(latestTranslateResult.data.translations[0])")
                
                
                self.textTranslate.text = latestTranslateResult.data.translations.first?.translatedText
                
            }
            
            
        }
        
    }
}

extension TranslatorViewController: LanguageListViewControllerDelegate {
    func didSelectSourceLanguage(language: Language) {
        sourceLanguage = language
    }
    
    func didSelectTargetLanguage(language: Language) {
        targetLanguage = language
    }
}


