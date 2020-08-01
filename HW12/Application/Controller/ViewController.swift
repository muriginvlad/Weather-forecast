//
//  ViewController.swift
//  HW12
//
//  Created by Владислав on 03.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet var weatherImageNow: UIImageView!
    @IBOutlet var cityLabelNow: UILabel!
    @IBOutlet var tempLabelNow: UILabel!
    @IBOutlet var weatherStatusLabelNow: UILabel!
    @IBOutlet var weatherWeekButton: UIButton!
    
    var weathers: [WeatherNowData] = []
    var weatherData: [WeatherNowData] = []
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherWeekButton.layer.cornerRadius = 20
                
        WeatherLoader().loadWeathers2 { weathers in
            self.weathers = weathers
        }
        
        if let savedWeatherNowData = self.defaults.object(forKey: "savedWeatherNowData") as? Data {
            let decoder = JSONDecoder()
            if let weatherData = try? decoder.decode([WeatherNowData].self, from: savedWeatherNowData) {
                self.weatherData = weatherData
            }
        }
        
        weathers = weatherData
        self.updateWeather()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateWeather () {
        tempLabelNow.text = String(weathers[0].currentWeather)
        weatherStatusLabelNow.text = weathers[0].description
        weatherImageNow.image = UIImage(named: "\(weathers[0].updateWeatherIcon(condition: weathers[0].condition))")
        cityLabelNow.text = weathers[0].city
    }
}
