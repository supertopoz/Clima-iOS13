//
//  WeatherData.swift
//  Clima
//
//  Created by Jason.Allshorn on 2020/11/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
