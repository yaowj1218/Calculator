//
//  calculator brain.swift
//  Calculater
//
//  Created by 姚文杰 on 2017/5/3.
//  Copyright © 2017年 姚文杰. All rights reserved.
//

import Foundation

func multiply(op1:Double,op2:Double)->Double{
    return op1*op2
}

class CalculatorBrain{
    
    private var accumulator = 0.0
    
    func setOperand(operand:Double){
        accumulator=operand
    }
    
   private var operations: Dictionary<String,Operation> = [
        "π":Operation.Constant(M_PI),
        "e":Operation.Constant(M_E),
        "√":Operation.UnaryOperation(sqrt),
        "×":Operation.BinaryOperation({ $0 * $1 }),
        "+":Operation.BinaryOperation({ $0 + $1 }),
        "-":Operation.BinaryOperation({ $0 - $1 }),
        "÷":Operation.BinaryOperation({ $0 / $1 }),
        
        "cos":Operation.UnaryOperation(cos),
        "=":Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
     func performOpreand(symbol:String) {
        
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator=value
            case .UnaryOperation(let function):
                accumulator=function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperationInfo()
                pending=PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperationInfo()
                
            }
        }
    }
    private func executePendingBinaryOperationInfo(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    private var pending:PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction:(Double,Double)->Double
        var firstOperand:Double
    }
    
    var result:Double  {
        get{
            return accumulator
        }
    }
}
