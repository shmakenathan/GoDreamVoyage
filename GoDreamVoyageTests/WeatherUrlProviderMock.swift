//
//  ConverterUrlProviderMock.swift
//  GoDreamVoyageTests
//
//  Created by Nathan on 22/09/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
@testable import GoDreamVoyage

class WeatherUrlProviderMock: WeatherUrlProvider {
    override func createUrl(city: String) -> URL? {
        return nil
    }
}
