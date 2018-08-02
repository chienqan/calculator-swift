//
//  ViewController.swift
//  calculator
//
//  Created by Chien on 8/1/18.
//  Copyright © 2018 Chien. All rights reserved.
//

import UIKit
import MathParser

class ViewController: UIViewController {
    
    @IBOutlet weak var screen: UILabel!
    
    var performMath: Bool = false
    var previousValue: String = ""
    var currentValue: String = ""
    var currentOperator: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numbers(_ sender: UIButton) {
        
        var text = getScreenText()
        
        if(text.first == "0") {
            text = ""
        }
        
        if(performMath) {
            performMath = false
            text = ""
        }
        
        screen.text = text + String(sender.tag)
    }
    
    
    @IBAction func clear(_ sender: Any) {
        screen.text = "0";
    }
    
    
    @IBAction func operators(_ sender: UIButton) {
        previousValue = getScreenText()
        currentOperator = detectOperator(tag: sender.tag)
        performMath = true
    }
    
    @IBAction func calculate(_ sender: Any) {
        let currentValue = getScreenText()
        let expression = "\(previousValue) \(currentOperator) \(currentValue)"
        
        let result = try? expression.evaluate()
        
        screen.text = String(result!).replacingOccurrences(of: ".0", with: "")
        setToDefaultValue()
    }
    
    func getScreenText() -> String {
        return screen.text ?? "0"
    }
    
    func setToDefaultValue() {
        performMath = false
        previousValue = ""
        currentValue = ""
        currentOperator = ""
    }
    
    func detectOperator(tag: Int) -> String {
        var result:String = ""
        
        if(tag == 10) {
            result = "+"
        }
        
        if(tag == 11) {
            result = "-"
        }
        
        if(tag == 12) {
            result = "*"
        }
        
        if(tag == 13) {
            result = "/"
        }
        
        return result
    }
    
}

