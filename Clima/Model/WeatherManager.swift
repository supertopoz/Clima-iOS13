//
//  WeatherManager.swift
//  Clima
//
//  Created by Jason.Allshorn on 2020/11/19.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=324bf9c1c5e0d3dc52049527b02651e5&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                self.parseJSON(weatherData: data)
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
      //  print(String(data: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
        

    }
    
}
