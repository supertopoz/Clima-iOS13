//
//  WeatherManager.swift
//  Clima
//
//  Created by Jason.Allshorn on 2020/11/19.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherMangerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=324bf9c1c5e0d3dc52049527b02651e5&units=metric"
    
    var delegate: WeatherMangerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchweather(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest (with urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let weather  = self.parseJSON(data) {
                    self.delegate?.didUpdateWeather(self, weather: weather)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
      //  print(String(data: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            return WeatherModel(conditionId: id, cityName: city, temperature: temp)
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

    
}
