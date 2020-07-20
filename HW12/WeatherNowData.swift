//
//  WeatherDataModel.swift
//  HW12
//
//  Created by Владислав on 08.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//

import UIKit

class WeatherNowData{
    
    var currentWeather = 0
    var condition = 0
    var weatherIconName = ""
    var description = ""
    var city = ""

    init?(data: NSDictionary) {
        
  
        
        guard
            let city = data["name"] as? String,
            let weatherData = data["main"] as? NSDictionary,
            let currentWeather = weatherData["temp"] as? NSNumber,
            let weatherCondition = data["weather"] as? NSArray,
            let weather = weatherCondition[0] as? NSDictionary,
            let condition = weather["id"] as? NSNumber,
            let description = weather["description"] as? String
            else {
            return nil
        }
        
        
        
        self.currentWeather = currentWeather.intValue
        self.condition = condition.intValue
        self.description = description
        self.city = city

    
        
    }
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
        case 0...300 :
            return "tstorm1"
        case 301...500 :
            return "light_rain"
        case 501...600 :
            return "shower3"
        case 601...700 :
            return "snow4"
        case 701...771 :
            return "fog"
        case 772...799 :
            return "tstorm3"
        case 800 :
            return "sunny"
        case 801...804 :
            return "cloudy2"
        case 900...903, 905...1000  :
            return "tstorm3"
        case 903 :
            return "snow5"
        case 904 :
            return "sunny"
        default :
            return "dunno"
        }
    }
}
