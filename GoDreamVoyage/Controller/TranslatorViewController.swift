//
//  TranslatorViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 16/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class TranslatorViewController: BaseViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if
            let languageListViewController = segue.destination as? LanguageListViewController,
            let senderButton = sender as? UIButton {
            languageListViewController.isSourceLanguageSelection = senderButton.tag == 0
            languageListViewController.delegate = self
        }
    }
   
    @IBOutlet weak var convertButtonTranslate: UIButton!
    
    @IBOutlet weak var sourceLanguageButton: UIButton!
    @IBOutlet weak var targetLanguageButton: UIButton!
    
    @IBOutlet weak var targetLanguageLabel: UILabel!
    
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        
            textTotranslate.resignFirstResponder()
            textTranslate.resignFirstResponder()
        
    }
    
    
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
    
    
    @IBAction func change(_ sender: UIButton) {
        let languageCible = sourceLanguage
        sourceLanguage = targetLanguage
        targetLanguage = languageCible
    }
    
    @IBAction func converter(_ sender: UIButton) {
        changeLoadingIndicatorVisibility(shouldShow: true)
        guard let textToTranslate = textTotranslate.text else {
            print("notext")
            return
        }
        
        translatorNetworkManager.fetchTranslation(
            baseLanguage: sourceLanguage.initial,
            returnLanguage: targetLanguage.initial,
            textToTranslate: textToTranslate,
            completionHandler: handleTranslationResultResponse(result:))
        
    
        
    }
    
    private let translatorNetworkManager = TranslatorNetworkManager()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        convertButtonTranslate.layer.cornerRadius = 10
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
            self.changeLoadingIndicatorVisibility(shouldShow: false)
            
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


