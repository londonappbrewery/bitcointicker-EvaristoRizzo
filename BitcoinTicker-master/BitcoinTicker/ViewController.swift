//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    var bitResult : Double = 0

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])

        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitCoinData(url: finalURL)
    }


    
    
    
    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitCoinData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the data")
                    let bitCoinJSON : JSON = JSON(response.result.value!)
                    
                    self.updateBitCoinData(json: bitCoinJSON)
                    
                } else {
                    print("Error: \(response.result.error!)")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
        
    }
   
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitCoinData(json : JSON) {
        
        bitResult = json["averages"]["day"].double!
        bitcoinPriceLabel.text = String(bitResult)
        
        
    }
    


}

