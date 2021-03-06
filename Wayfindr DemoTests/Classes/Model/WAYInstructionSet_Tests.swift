//
//  WAYInstructionSet_Tests.swift
//  Wayfindr Demo
//
//  Created by Wayfindr on 10/11/2015.
//  Copyright (c) 2016 Wayfindr (http://www.wayfindr.net)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights 
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all 
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import Wayfindr_Demo

import AEXML

class WAYInstructionSet_Tests: XCTestCase {
    
    
    // MARK: - Properties

    var xmlElement : AEXMLElement!
    
    private let beginning = "Welcome to station X. Where would you like to go? Please select from the list... Walk forwards and bear right towards the ticket barrier. You will find some tactile paving."
    private let middle = "You are approaching the ticket barrier."
    private let ending = "Follow the tactile paving towards the platform."
    
    
    // MARK: - Setup/Teardown
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        xmlElement = AEXMLElement()
        xmlElement.name = "edge"
        xmlElement.attributes["id"] = "e0"
        xmlElement.attributes["source"] = "0"
        xmlElement.attributes["target"] = "1"
        xmlElement.addChild(name: "data", value: "1.0", attributes: ["key" : "travel_time"])
        xmlElement.addChild(name: "data", value: beginning, attributes: ["key" : "beginning"])
        xmlElement.addChild(name: "data", value: middle, attributes: ["key" : "middle"])
        xmlElement.addChild(name: "data", value: ending, attributes: ["key" : "ending"])
        xmlElement.addChild(name: "data", value: "en-GB", attributes: ["key" : "language"])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Initializers

    func testInitXMLElement_GoodXML() {
        // When
        let testInstructions = try? WAYInstructionSet(xmlElement: xmlElement)
        
        // Then
        XCTAssertNotNil(testInstructions, "Initialization of instruction set from well formed GraphML expected to be not nil.")
    }
    
    func testInitXMLElement_BadXML_Data() {
        // Given
        let badXMLElement = xmlElement
        
        // When
        badXMLElement.children.last?.removeFromParent()
        
        // Then
        AssertThrow(WAYError.InvalidInstructionSet, try WAYInstructionSet(xmlElement: badXMLElement))
    }
    
    
    // MARK: - Convenience Getters
    
    func testAllInstructions() {
        // Given
        let testInstructions = try! WAYInstructionSet(xmlElement: xmlElement)
        
        // When
        let allInstructions = testInstructions.allInstructions()
        
        // Then
        XCTAssertTrue(allInstructions.count == 3, "Expected 3 instructions in the set. Only fonud \(allInstructions.count)")
        XCTAssertTrue(allInstructions[0] == beginning, "Did not find correct `beginning` instruction. Expected \(beginning). Received \(allInstructions[0]).")
        XCTAssertTrue(allInstructions[1] == middle, "Did not find correct `middle` instruction. Expected \(middle). Received \(allInstructions[1]).")
        XCTAssertTrue(allInstructions[2] == ending, "Did not find correct `ending` instruction. Expected \(ending). Received \(allInstructions[2]).")
    }
    
}
