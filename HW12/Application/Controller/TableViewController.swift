//
//  TableViewController.swift
//  HW12
//
//  Created by Владислав on 08.07.2020.
//  Copyright © 2020 Murygin Vladislav. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var weathers: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherLoader().loadWeathers { weathers in
            self.weathers = weathers
            self.tableView.reloadData()
        }
    }
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        
        let weather = weathers[indexPath.row]
        cell.weatherStatusLabelCell.text = weather.description
        cell.weatherTempDayCell.text = String(weather.currentWeather)
        cell.dayLabelCell.text = weather.data
        cell.dayTimeLabelCell.text = weather.time
        cell.weatherImageCell.image = UIImage(named: "\(weather.updateWeatherIcon(condition: weather.condition))")
  
        
        return cell
        
    }
}
