//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol ByteCoinManagerDelegate  {
    func didUpdateCurrency(_ coinManager: CoinManager, currency: Double)
    func didFailWithError(error:Error)
}
struct CoinManager {
    var delegate: ByteCoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "D6269524-F2A6-4995-BC18-9F2CA664686A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPirce(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        //Create a URL
        if let url = URL(string: urlString){
            //Create URLSesion
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return //exit and dont continue like BREAK
                }
                if let safeData = data{
                    //inside a closure you must add the word self when using a function from outside
                    if let currency = self.parseJSON(safeData){
                        self.delegate?.didUpdateCurrency(self, currency: currency)
                    }
                }
            }
            //start the task
            task.resume()
        }
    }
    func parseJSON(_ currecnyData: Data)-> Double?{
        let decoder = JSONDecoder()
     
        do {
            //weatherData.self is the type not an object
            let decodedData = try decoder.decode(CurrencyModel.self, from: currecnyData)
            let rate = decodedData.rate
            return rate
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
