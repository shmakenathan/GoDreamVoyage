import Foundation

class ConverterUrlProviderMock: ConverterUrlProvider {
    override func createUrl() -> URL? {
        return nil
    }
}


class ConverterUrlProvider {
    func createUrl() -> URL? {
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
}


class CurrencyNetworkManager {
    
    init(
        networkManager: NetworkManager = NetworkManager(),
        converterUrlProvider: ConverterUrlProvider = ConverterUrlProvider()
    ) {
        self.networkManager = networkManager
        self.converterUrlProvider = converterUrlProvider
    }
    
    private let converterUrlProvider: ConverterUrlProvider
    private let networkManager: NetworkManager
    
    
    func fetchCurrencyConverter(completionHandler: @escaping (Result<CurrencyResponseResult, NetworkManagerError>) -> Void) {
        
        guard let url = converterUrlProvider.createUrl() else {
            completionHandler(.failure(.unknownErrorOccured))
            return
        }
        networkManager.fetchResult(url: url, completionHandler: completionHandler)
    }
}
