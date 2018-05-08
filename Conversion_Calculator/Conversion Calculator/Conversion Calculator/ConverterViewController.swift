//
//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Eric Rachell on 4/13/18.
//  Copyright © 2018 Eric Rachell. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var displayOutput: UITextField!
    @IBOutlet weak var displayInput: UITextField!
    ///////////Custom Struct Created Here ///////
    struct conversionFactor{
        var label = ""
        var inputUnit = ""
        var outputUnit = ""
    }
//////////////////////////////////////////////
    var tempString: String = ""
    var numInput: Double = 0
    var numOutput: Double = 0
    
    var convertDefaults = [conversionFactor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertDefaults = [
            conversionFactor(label: "Kilometers to Miles", inputUnit: "km", outputUnit: "mi"),
            conversionFactor(label: "Miles to Kilometers", inputUnit: "mi", outputUnit: "km"),
            conversionFactor(label: "Fahrenheit to Celcius", inputUnit: "°F", outputUnit: "°C"),
            conversionFactor(label: "Celcius to Fahrenheit", inputUnit: "°C", outputUnit: "°F")
        ]
        displayInput.text = convertDefaults[3].inputUnit
        displayOutput.text = convertDefaults[3].outputUnit
        displayInput.textAlignment = NSTextAlignment.right
        displayOutput.textAlignment = NSTextAlignment.right

    }

    
    @IBAction func converterPressed(_ sender: UIButton) {
        let conversionModal = UIAlertController( title: "Choose a Conversion Factor", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        /////////////////////////////////Loop through choices here.////////////////////////
        for choices in convertDefaults
        {
            conversionModal.addAction(UIAlertAction( title: choices.label, style: UIAlertActionStyle.default, handler: {
                (alertAction) -> Void in

                self.displayInput.textAlignment = NSTextAlignment.right
                self.displayOutput.textAlignment = NSTextAlignment.right
                self.displayInput.text = choices.inputUnit
                self.displayOutput.text = choices.outputUnit
                

            }))
        }
        
        //I noticed that the calculator retains the last number typed after a conversion
        //Thus, a hard variable reset is needed.
    numOutput = 0
    numInput = 0
    tempString = ""
        
        ///end reset
    self.present(conversionModal, animated:false,  completion: nil)
    }
   

    @IBAction func actualNumbers(_ sender: UIButton) {
        
        if (displayOutput.text!.contains("°C")){
            tempString = tempString + String(sender.tag-1)
            displayInput.text = tempString + " °F"
            numInput = Double(tempString)!
            numOutput = fToC(numInput: numInput)
            displayOutput.text = String(numOutput) + " °C"
        }
        
        if (displayOutput.text!.contains("°F")){
            tempString = tempString + String(sender.tag-1)
            displayInput.text = tempString + " °C"
            numInput = Double(tempString)!
            numOutput = cToF(numInput: numInput)
            displayOutput.text = String(numOutput) + " °F"
        }
        
        if (displayOutput.text!.contains("km")){
            tempString = tempString + String(sender.tag-1)
            displayInput.text = tempString + " mi"
            numInput = Double(tempString)!
            numOutput = mToKi(numInput: numInput)
            displayOutput.text = String(numOutput) + " km"
        }
        
        if (displayOutput.text!.contains("mi")){
            tempString = tempString + String(sender.tag-1)
            displayInput.text = tempString + " km"
            numInput = Double(tempString)!
            numOutput = kiToM(numInput: numInput)
            displayOutput.text = String(numOutput) + " mi"
        }
    }
    
    ////Main Conversion Functions Here/////
    
    func fToC(numInput: Double) -> Double {
        numOutput = (numInput - 32) * (5/9)
        return numOutput
    }
  
    func mToKi(numInput: Double) -> Double {
        numOutput = (numInput * 1.60934)
        return numOutput
    }
    
    func kiToM(numInput: Double) -> Double {
        numOutput = (numInput * 0.62137)
        return numOutput
    }
    
    func cToF(numInput: Double) -> Double {
        numOutput = (numInput * (9/5) + 32)
        return numOutput
    }
    
    
    
    @IBAction func readNumber(_ sender: UIButton)
    {
       
  
 
        if sender.tag != 13
        {
            if sender.tag == 12{
                if numInput == 0 {
                    return
                }
                
                if displayOutput.text!.contains("°C") {
                    numInput = numInput * -1
                    displayInput.text = String(numInput) + "°F"
                    numOutput = fToC(numInput: numInput)
                    displayOutput.text = String(numOutput) + "°C"
                }
                else if displayOutput.text!.contains("°F") {
                    numInput = numInput * -1
                    displayInput.text = String(numInput) + "°C"
                    numOutput = cToF(numInput: numInput)
                    displayOutput.text = String(numOutput) + "°F"
                }
                else if displayOutput.text!.contains("km") {
                    numInput = numInput * -1
                    displayInput.text = String(numInput) + " mi"
                    numOutput = mToKi(numInput: numInput)
                    displayOutput.text = String(numOutput) + " km"
                }
                else if displayOutput.text!.contains("mi") {
                    numInput = numInput * -1
                    displayInput.text = String(numInput) + " km"
                    numOutput = kiToM(numInput: numInput)
                    displayOutput.text = String(numOutput) + " mi"
                }
            }
        }
        
        if sender.tag == 14
        {
            if displayInput.text!.contains("."){
                return
            }
            else if displayOutput.text!.contains("°C"){
                tempString = tempString + "."
                numInput = Double(Double(tempString)!)
                displayInput.text = String(numInput) + " °F"
            }
            
            else if displayOutput.text!.contains("°F"){
                tempString = tempString + "."
                numInput = Double(Double(tempString)!)
                displayInput.text = String(numInput) + " °C"
            }
            
            else if displayOutput.text!.contains(" km"){
                tempString = tempString + "."
                numInput = Double(Double(tempString)!)
                displayInput.text = String(numInput) + " mi"
            }
            
            else if displayOutput.text!.contains(" mi"){
                tempString = tempString + "."
                numInput = Double(Double(tempString)!)
                displayInput.text = String(numInput) + " km"
            }
        } else if sender.tag == 13 {
            numOutput = 0
            numInput = 0
            tempString = ""
            if displayOutput.text!.contains("°C"){
                displayOutput.text = "°C"
                displayInput.text = "°F"
            } else if displayOutput.text!.contains("°F"){
                displayOutput.text = "°F"
                displayInput.text = "°C"
            } else if displayOutput.text!.contains("km"){
                displayOutput.text = "km"
                displayInput.text = "mi"
            } else if displayOutput.text!.contains("mi"){
                displayOutput.text = "mi"
                displayInput.text = "km"
            }
            
            
        }
     
    }
    
    

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    

    

}
