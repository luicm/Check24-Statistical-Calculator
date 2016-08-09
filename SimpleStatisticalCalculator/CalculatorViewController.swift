//
//  ViewController.swift
//  SimpleStatisticalCalculator
//
//  Created by Luisa on 09/08/16.
//  Copyright © 2016 Luisa. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var decimalIsPressed = false
    var brain = Operator()
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                self.history.text = String(result)
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        decimalIsPressed = false
        
        let result = brain.pushValue(displayValue)
        displayValue = result.last!
        
        let stringArray = result.flatMap { String($0) }
        history.text = stringArray.joinWithSeparator(", ")
    }
    
    @IBAction func decimal() {
        userIsInTheMiddleOfTypingANumber = true
        if decimalIsPressed == false {
            display.text = display.text! + "."
            decimalIsPressed = true
        }
    }
    
    @IBAction func replaceValue(sender: UIButton) {
        var indexTextField: UITextField?
        var newValueTextField: UITextField?
        
        let alertController = UIAlertController(title: "Replace Value", message: "Introduce the position of the value you want to replace and the new value", preferredStyle: .Alert)
        
        let ok = UIAlertAction(title: "Replace", style: .Default, handler: { (action) -> Void in
            if let indexString = indexTextField?.text, let index = Int(indexString), let valueString = newValueTextField?.text, let newValue = Double(valueString) {
                let result = self.brain.performReplaceIndex(index, newValue: newValue)
                let stringArray = result.flatMap { String($0) }
                self.history.text = stringArray.joinWithSeparator(", ")
                
            } else {
              //TODO:
            }
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            indexTextField = textField
            indexTextField?.placeholder = "Position"
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            newValueTextField = textField
            newValueTextField?.placeholder = "New Value"
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func removeValue(sender: UIButton) {
        var indexTextField: UITextField?
        let alertController = UIAlertController(title: "Remove Value", message: "Introduce the position of the value you want to remove", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Remove", style: .Default, handler: { (action) -> Void in
            
            if let indexString = indexTextField?.text, let index = Int(indexString) {
                let result = self.brain.performRemoveFromIndex(index)
                let stringArray = result.flatMap { String($0) }
                self.history.text = stringArray.joinWithSeparator(", ")

            } else {
                //TODO:
            }
            
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            indexTextField = textField
            indexTextField?.placeholder = "Position"
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteValueFromDisplay(sender: UIButton) {
        if let value = display.text {
            let newValue = value.substringToIndex(value.endIndex.predecessor())
            if newValue.isEmpty {
                display.text = "0.0"
            } else {
                display.text = newValue
                userIsInTheMiddleOfTypingANumber = false
                decimalIsPressed = false
            }
            
        }
    }
    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        display.text = "0.0"
        history.text = "0"
        brain.performClear()
        
    }
    
}

