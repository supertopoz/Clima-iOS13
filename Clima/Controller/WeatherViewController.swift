//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       searchTextField.delegate = self
        weatherManager.delegate = self
        // Do any additional setup after loading the view.
        
    }

    

}

//MARK: - UITesxtfieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print(searchTextField.text)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
        
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherMangerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager,  weather: WeatherModel) {
        print(weather.temperature)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            print(weather.conditionName)
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
