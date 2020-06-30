//
//  TranslatorNetworkManager.swift
//  GoDreamVoyage
//
//  Created by Nathan on 30/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation


class TranslatorNetworkManager {
    
    
    func createUrl(baseLanguage : String, returnLanguage : String, textToTranslate : String) -> String {
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
        
        
        guard let url = urlComponents.string else {
            return ""
        }
        return url
    }
    
    
    
    
    
    
    
    
    
    
    
    func fetchResult(url: URL, completionHandler: @escaping (Result<TranslateResponseResult, NetworkManagerError>) -> Void) {
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.unknownErrorOccured))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...399 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponseStatusCode))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            guard let result = try? JSONDecoder().decode(TranslateResponseResult.self, from: data) else {
                completionHandler(.failure(.couldNotDecodeJson))
                return
            }
            
            completionHandler(.success(result))
            
        }
        
        task.resume()
        
    }
    
}
