//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,ByteCoinManagerDelegate {
    

    @IBOutlet weak var ByteCoinLabel: UILabel!
    @IBOutlet weak var CurrencyLabel: UILabel!
    @IBOutlet weak var CurrencyPicker: UIPickerView!
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyPicker.dataSource = self
        CurrencyPicker.delegate = self
        ByteCoinLabel.text = "0.0000"
        CurrencyLabel.text = "Currency"
        coinManager.delegate = self
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPirce(for: coinManager.currencyArray[row])
        CurrencyLabel.text = coinManager.currencyArray[row]
//        print(coinManager.currencyArray[row])
    }
    func didUpdateCurrency(_ coinManager: CoinManager, currency: Double){
        
        DispatchQueue.main.async {
            self.ByteCoinLabel.text = String(format: "%.1f", currency)
        }
        
    }

    func didFailWithError(error: Error) {
        print(error);
    }

}

