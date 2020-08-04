//
//  TranslatorViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 16/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit

class TranslatorViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var textTranslate: UITextView!
    @IBOutlet weak var convertButtonTranslate: UIButton!
    @IBOutlet weak var sourceLanguageButton: UIButton!
    @IBOutlet weak var targetLanguageButton: UIButton!
    @IBOutlet weak var targetLanguageLabel: UILabel!
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
            textToTranslate.resignFirstResponder()
    }
    
    @IBAction func change(_ sender: UIButton) {
        let languageCible = sourceLanguage
        sourceLanguage = targetLanguage
        targetLanguage = languageCible
    }
    
    @IBAction func converter(_ sender: UIButton) {
        changeLoadingIndicatorVisibility(shouldShow: true)
        guard let textToTranslate = textToTranslate.text else {
            print("notext")
            return
        }
        translatorNetworkManager.fetchTranslation(
            baseLanguage: sourceLanguage.initial,
            returnLanguage: targetLanguage.initial,
            textToTranslate: textToTranslate,
            completionHandler: handleTranslationResultResponse(result:))
    }

    // MARK: Properties - Private
    
    private var sourceLanguage = Language.French {
        didSet {
            sourceLanguageButton.setTitle(sourceLanguage.title, for: .normal)
            sourceLanguageLabel.text = sourceLanguage.title
        }
    }
    
    private var targetLanguage = Language.English {
        didSet {
            targetLanguageButton.setTitle(targetLanguage.title, for: .normal)
            targetLanguageLabel.text = targetLanguage.title
        }
    }
    
    private let translatorNetworkManager = TranslatorNetworkManager()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        textToTranslate.addDoneButtonOnKeyboard()
        convertButtonTranslate.layer.cornerRadius = 10
        sourceLanguage = Language.French
        targetLanguage = Language.English
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if
            let languageListViewController = segue.destination as? LanguageListViewController,
            let senderButton = sender as? UIButton {
            languageListViewController.isSourceLanguageSelection = senderButton.tag == 0
            languageListViewController.delegate = self
        }
    }
    
    // MARK: Methods - Private
    
    private func handleTranslationResultResponse(result: Result<TranslateResponseResult, NetworkManagerError>) {
        DispatchQueue.main.async {
            self.changeLoadingIndicatorVisibility(shouldShow: false)
            switch result {
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.message)
            case .success(let latestTranslateResult):
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
