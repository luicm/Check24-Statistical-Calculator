//
//  Operator.swift
//  SimpleStatisticalCalculator
//
//  Created by Luisa on 09/08/16.
//  Copyright © 2016 Luisa. All rights reserved.
//

import Foundation

class Operator {
    
    enum Operators {
        case Sum, Mean, SqaredMean
    }
    
    let knownOperations = ["+": Operators.Sum, "ẍ": Operators.Mean, "ẍ²": Operators.SqaredMean]
    
    var valueList = [Double]()
    
    func pushValue(operand: Double) -> [Double] {
        valueList.append(operand)
        return valueList
    }
    
    func performRemoveFromIndex(index: Int) -> [Double] {
        valueList.removeAtIndex(index-1)
        return valueList
    }

    func performReplaceIndex(index: Int, newValue: Double) -> [Double] {
        valueList[index-1] = newValue
        return valueList
    }
    
    func performOperation(symbol: String) -> Double? {
        if let knowOperation = knownOperations[symbol] {
            switch knowOperation {
            case .Sum:
                let result = sumValue(valueList)
                valueList = [result]
                return result
            case .Mean:
                let result = meanValue()
                valueList = [result]
                return result
                
            case .SqaredMean:
                let result = meanSquaredValue()
                valueList = [result]
                return result
            }
        }
        return nil
    }
    
    func performClear() {
        valueList.removeAll()
    }
    
    private func sumValue(list: [Double]) -> Double {
        return list.reduce(0, combine: +)
    }
    
    private func meanValue() -> Double {
        let count = valueList.count
        return sumValue(valueList)/Double(count)
    }
    
    private func meanSquaredValue() -> Double {
        let sqaredValueList = valueList.map { $0 * $0 }
        let count = sqaredValueList.count
        return sumValue(sqaredValueList)/Double(count)
    }
}
