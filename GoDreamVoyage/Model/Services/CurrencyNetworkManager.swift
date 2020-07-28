import Foundation
class CurrencyNetworkManager {
    
    
    private func createUrl() -> URL? {
        // TODO: Move function into its own service like "TranslatorNetworkManager"
        // TODO: Use URLComponent to create the url instead of appending string
        // TODO: Use add percent encoding for string to url
        
        let access_key = "aaa3bb4285d0f3ba1bcda2fc1926c039"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: access_key)
        ]
        
        

        return urlComponents.url
    }
    
    private let networkManager = NetworkManager()
    
    
    
    func fetchCurrencyConverter(completionHandler: @escaping (Result<LatestCurrencyResult, NetworkManagerError>) -> Void) {
        
        guard let url = createUrl() else {
            completionHandler(.failure(.unknownErrorOccured))
            return
        }
        print(url)
        networkManager.fetchResult(url: url, completionHandler: completionHandler)
    
    
    }
    
    
    
}
