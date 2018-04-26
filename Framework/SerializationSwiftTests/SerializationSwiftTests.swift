//
//  SerializationSwiftTests.swift
//  SerializationSwiftTests
//
//  Created by Rone Loza on 4/23/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import XCTest
@testable import SerializationSwift

class SerializationSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadWebData() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download apple.com home page")
        
        NetworkManager.shared().getItunesLookup(identifier: "1340448711") { (state: ResponseState, model: LookupMetadata?) -> (Void) in
            
            if (state == .Success) {
                
                if let data = model {
                    
                    print(data)
                }
            }
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(model, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }
        
        // Start the download task.
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 60.0)
    }
    
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
