//
//  SimpleStatisticalCalculatorTests.swift
//  SimpleStatisticalCalculatorTests
//
//  Created by Luisa on 09/08/16.
//  Copyright © 2016 Luisa. All rights reserved.
//

import XCTest
@testable import SimpleStatisticalCalculator

class SimpleStatisticalCalculatorTests: XCTestCase {
    
    private let brain = Operator()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSumOfListValue() {
        let valueList = [10.0, 7.0, 18.0, 4.0, 14.0]
        brain.valueList = valueList
        
        let result = brain.performOperation("+")
        
        XCTAssertEqual(result, 53, "Result must be equal to 53")
    }
    
    func testMeanOfListValue() {
        let valueList = [10.0, 7.0, 18.0, 4.0, 14.0]
        brain.valueList = valueList
        
        let result = brain.performOperation("ẍ")
        if let result = result {
            XCTAssertEqual(result, 10.6, "Result must be equal to 10.6")
        }
    }
    
    func testMeanSquaredOfListValue() {
        let valueList = [10.0, 7.0, 18.0, 4.0, 14.0]
        brain.valueList = valueList
        
        let result = brain.performOperation("ẍ²")
        
        XCTAssertEqual(result, 137, "Result must be equal to 137")
    }
    
    func testPerformReplacementAtIndex() {
        let valueList = [10.0, 7.0, 18.0, 4.0, 14.0]
        brain.valueList = valueList
        
        let result = brain.performReplaceIndex(2, newValue: 2.5)
        XCTAssertEqual(result, [10.0, 2.5, 18.0, 4.0, 14.0], "Result must be equal to [10.0, 2.5, 18.0, 4.0, 14.0]")
    }
    
    func testPerformRemoveAtIndex() {
        let valueList = [10.0, 7.0, 18.0, 4.0, 14.0]
        brain.valueList = valueList
        
        let result = brain.performRemoveFromIndex(2)
        
        XCTAssertEqual(result, [10.0, 18.0, 4.0, 14.0], "Result must be equal to [10.0, 7.0, 4.0, 14.0]")
        
        
    }
}
