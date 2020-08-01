//
//  WeatherDataModel.swift
//  HW12
//
//  Created by Владислав on 04.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//

import UIKit

struct WeatherData: Codable{
    
    var currentWeather = 0
    var condition = 0
    var weatherIconName = ""
    var description = ""
    var weatherMaxTempCell: Double = 0.0
    var weatherMinTempCell: Double = 0.0
    
    private var dataTime : Double
    
    var data: String {
        let date = Date(timeIntervalSince1970: dataTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
    var time: String {
        let date = Date(timeIntervalSince1970: dataTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    

    init?(data: NSDictionary) {

        guard
            let weatherData = data["main"] as? NSDictionary,
            let currentWeather = weatherData["temp"] as? NSNumber,
            let weatherMinTempCell = weatherData["temp_min"] as? NSNumber,
            let weatherMaxTempCell = weatherData["temp_max"] as? NSNumber,
            let weatherCondition = data["weather"] as? NSArray,
            let weather = weatherCondition[0] as? NSDictionary,
            let condition = weather["id"] as? NSNumber,
            let description = weather["description"] as? String,
            let dataTime = data["dt"] as? NSNumber
            else {
            return nil
        }
        
        
        
        self.currentWeather = currentWeather.intValue
        self.condition = condition.intValue
        self.description = description
        self.weatherMaxTempCell = weatherMaxTempCell.doubleValue
        self.weatherMinTempCell = weatherMinTempCell.doubleValue
        self.dataTime =  dataTime.doubleValue
    
        
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
