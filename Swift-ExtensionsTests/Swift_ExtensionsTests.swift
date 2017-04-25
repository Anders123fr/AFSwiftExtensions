//
//  Swift_ExtensionsTests.swift
//  Swift-ExtensionsTests
//
//  Created by Anders Friis on 25/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import XCTest
@testable import SwiftExtensions

class Swift_ExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	
	func testUIViewFrameAccessors() {
		let view = UIView(frame: CGRect(x: 0, y: 20, width: 500, height: 600))
		
		// Test origin
		var origin = view.origin
		XCTAssert(origin.x == view.x)
		XCTAssert(origin.y == view.y)
		
		origin.x = 45
		origin.y = 0
		view.set(origin: origin)
		XCTAssert(view.x == 45 && view.y == 0)
		
		view.set(x: 503)
		XCTAssert(view.x == 503)
		
		view.set(y: 782)
		XCTAssert(view.y == 782)
		
		
		// Test size
		var size = view.size
		XCTAssert(size.width == view.width)
		XCTAssert(size.height == view.height)

		size.width = 540
		size.height = 100
		view.set(size: size)
		XCTAssert(view.width == 540 && view.height == 100)
		
		view.set(width: 310)
		XCTAssert(view.width == 310)

		view.set(height: 680)
		XCTAssert(view.height == 680)

	}
	
	func testNSAttributedString() {
		let string = "Hej med dig"
		
		var attr = StringAttributes()
		attr.textColor = .yellow
		
		let attrStr = string.style(substring: "med", attributes: attr)
		print(attrStr)
		
		let attrStr2 = attrStr.style(substring: "Hej", attributes: attr)
		print(attrStr2)
	}
	
}
