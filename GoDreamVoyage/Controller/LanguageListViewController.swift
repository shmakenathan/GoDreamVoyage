//
//  LanguageListViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 22/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit


protocol LanguageListViewControllerDelegate: AnyObject {
    func didSelectSourceLanguage(language: Language)
    func didSelectTargetLanguage(language: Language)
}

class LanguageListViewController: UIViewController {
    weak var delegate: LanguageListViewControllerDelegate?
    var isSourceLanguageSelection = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LanguageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = Language.allCases[indexPath.row].title
        return cell
    }
}

extension LanguageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = Language.allCases[indexPath.row]
        
        isSourceLanguageSelection ?
            delegate?.didSelectSourceLanguage(language: selectedLanguage) :
            delegate?.didSelectTargetLanguage(language: selectedLanguage)
        self.dismiss(animated: true, completion: nil)
    }
}
