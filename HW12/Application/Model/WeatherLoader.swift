//
//  WeatherLoader.swift
//  HW12
//
//  Created by Владислав on 04.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//

import Foundation
import Alamofire 

let city = "Moscow"
let app_key = "5ab5b8a2057b34a888477a705432469c"
var weather_url = ""


class WeatherLoader{
    
    func loadWeathers(completion: @escaping ([WeatherData]) -> Void)  {
        
        weather_url = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&APPID=\(app_key)&lang=ru"
        
        let url = URL(string: "\(weather_url)")!
        let request = URLRequest(url: url)
        
        
        let task = URLSession.shared.dataTask(with: request) {data,response,error  in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json  as? NSDictionary{
                
                var weathers: [WeatherData] = []
                let arrayList = jsonDict["list"] as! NSArray
                                
                for item in arrayList {
                    if let currentWeather = WeatherData(data: item as! NSDictionary){
                        weathers.append(currentWeather)
                    }
                }
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(weathers) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "savedWeatherData")
                }
                
                DispatchQueue.main.async {
                    completion(weathers)
                }
            }
        }
        task.resume()
    }
    
    
    func loadWeathers2(completion: @escaping ([WeatherNowData]) -> Void)  {
        _ =  AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(app_key)&lang=ru&units=metric").responseJSON
        { response in
            if let objects = try? response.result.get(), let jsonDict = objects as? NSDictionary
            {

                var weathers: [WeatherNowData] = []
                
                let vocabularyWeather = WeatherNowData(data: jsonDict )
                weathers.append(vocabularyWeather!)
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(weathers) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "savedWeatherNowData")
                }
                                
                DispatchQueue.main.async {
                    completion(weathers)
                }
            }
        }
    }
    
}
