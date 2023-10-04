//
//  ViewController.swift
//  CurrencyAppTesing
//
//  Created by Jad ghoson on 03/10/2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, CurrencyManagerDelegate {
    
   
    var currencyManager = CurrencyManager()
    
    @IBOutlet weak var CurrencyTF: UITextField!
    @IBOutlet weak var DigitalTF: UITextField!
    @IBOutlet weak var RateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate
        CurrencyTF.delegate = self
        DigitalTF.delegate  = self
        currencyManager.dalegate = self
    }
    
    
    
    @IBAction func CalculateButton(_ sender: UIButton) {
        CurrencyTF.endEditing(true)||DigitalTF.endEditing(true)
        let GCurrency = CurrencyTF.text
         let DCurrency = DigitalTF.text
        currencyManager.finderCurrency(digitalCurrency: DCurrency!, globalCurrency: GCurrency!)
       
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//we use this if for using the return for two UITextField
        
        if textField == CurrencyTF{
            CurrencyTF.endEditing(true)
            
        }else if
            textField == DigitalTF{
                DigitalTF.endEditing(true)
            }
        return true
        }
    /*func textFieldShouldEndEditing (_ textField: UITextField) -> Bool {        // I DONT THINK WE WANT THIS CODE FOR PLACE HOLDER INSIDE THIS APP BECAUSE ITS SO SIMPLY
        if textField == DigitalTF{
            if CurrencyTF.text != ""{
                return true
            }else{
                CurrencyTF.placeholder = "Global Currency"
                return false
            }
        }else if textField == DigitalTF{
            if DigitalTF.text != ""{
                return true
            }else{
                DigitalTF.placeholder = "Digital Currency"
                return false
            }
        }
        return true
    }*/
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        }
    func didUpdateCurrency(_ currencyManger: CurrencyManager, currency: CurrencyModel) {
        DispatchQueue.main.async{
            let Rate = "Rate:\(currency.result)"//i use this because i cant let the LabelText Read the Double or Float ;)
            self.RateLabel.text = Rate
        }
    }
    func didFaliWithError(error: Error){
        print(error)
    }

         
        }
    
    
    
    




