//
//  ViewController.swift
//  Calculater
//
//  Created by 姚文杰 on 2017/5/2.
//  Copyright © 2017年 姚文杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet private weak var display: UILabel!
    
     var isHaveNumber:Bool=false
    
    @IBAction private func numberButton(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        print("touch \(number) button")
       
        if isHaveNumber {
            let textCurrentInDisplay=display!.text!
            display!.text=textCurrentInDisplay+number
        }else{
            display!.text=number
        }
        isHaveNumber=true
    }
    
   private var  displayValue:Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text=String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func mathOperation(_ sender: UIButton) {
        if isHaveNumber{
            brain.setOperand(operand: displayValue)
            isHaveNumber=false
        }
        if let mathSymbol=sender.currentTitle
        {
            brain.performOpreand(symbol: mathSymbol)
        }
        displayValue=brain.result

    }
}
