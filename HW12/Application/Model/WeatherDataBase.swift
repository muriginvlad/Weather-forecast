//
//  WeatherDataBase.swift
//  HW12
//
//  Created by Владислав on 20.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//

import Foundation

class WeatherDataBase {
    
    static let shared = WeatherDataBase()

    private let lastWeatherKey = "WeatherDataBase.lastWeatherKey"

    var weather: [WeatherData] {
        set { UserDefaults.standard.set(newValue, forKey: lastWeatherKey) }
        get { return UserDefaults.standard.object(forKey: lastWeatherKey) as! [WeatherData]}
    }


    
//    var weatherTemp: String? {
//        set { UserDefaults.standard.set(newValue, forKey: lastWeatherKey) }
//        get { return UserDefaults.standard.string(forKey: lastWeatherKey) }
//    }
//
//    private let lastCondition = "Persistence.lastCondition"
//    var weatherCondition: String? {
//        set { UserDefaults.standard.set(newValue, forKey: lastCondition) }
//        get { return UserDefaults.standard.string(forKey: lastCondition) }
//    }

}


