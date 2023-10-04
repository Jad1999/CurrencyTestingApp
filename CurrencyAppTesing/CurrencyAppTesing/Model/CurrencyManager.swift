//
//  CurrencyManager.swift
//  CurrencyAppTesing
//
//  Created by Jad ghoson on 03/10/2023.
//

import Foundation
protocol CurrencyManagerDelegate{
    func didUpdateCurrency(_ currencyManger: CurrencyManager, currency:CurrencyModel)
}

struct CurrencyManager{//for APP currency to see the rating between the two currency
    
    let currencyURL = "https:rest.coinapi.io/v1/exchangerate"
    let keyAPI = "?apikey=54A6D0D1-643A-4BDA-995E-B52F45308A55"
    var dalegate: CurrencyManagerDelegate?
    
    func finderCurrency(digitalCurrency: String, globalCurrency: String){
        let urlString = "\(currencyURL)/\(digitalCurrency)/\(globalCurrency)\(keyAPI)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){// this Code is always the same for creating a URL Session
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in// we use this code by using the closures by remove the handle steps
                if error != nil {
                    print(error!)
                    return//its mean the code has been stoped and not continue if it find a error
                }
                if let safeData = data{
                    if  let currency = self.parseJSON(currencyData: safeData) {
                        self.dalegate?.didUpdateCurrency(self, currency:currency)
                    }
                }
                }
                task.resume()
                
                
            }
            
            
            
        }
        func parseJSON(currencyData: Data)-> CurrencyModel?{
            let decoder = JSONDecoder()
            do{
                let decodeData = try decoder.decode(CurrencyData.self, from: currencyData)
                let digital = decodeData.asset_id_base
                let global = decodeData.asset_id_quote
                let rate = decodeData.rate
                let currency = CurrencyModel.init(digitalId: digital, globalId: global, result: rate)
                print(currency)
                return currency
                
                
            }catch{
                print(error)
                
            }
            return nil
        }
    }

