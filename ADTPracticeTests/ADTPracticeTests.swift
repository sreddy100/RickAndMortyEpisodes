//
//  ADTPracticeTests.swift
//  ADTPracticeTests
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import XCTest
@testable import ADTPractice

class ADTPracticeTests: XCTestCase {
    let evm = EpisodesViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetData() throws {
        let promise = expectation(description: "Completion Handler Invoked")
        var error : Error?
        var retData : Any?
        evm.getData(1, Page.self) { (data, _, err) in
            error = err
            retData = data
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(retData)
        XCTAssertNil(error)
    }
    
    func testGetArrayCount() throws {
        let promise = expectation(description: "Completion Handler Invoked")
        evm.getData(1, Page.self) { (data, response, error) in
            promise.fulfill()
        }
        wait(for: [promise], timeout: 4)
        XCTAssertEqual(20, evm.getArrayCount())
    }
    
    func testSetArray() throws {
        let newEp = Episodes(id: 1, name: "TestName", airDate: "TestAirDate", episode: "TestEpisode", characters: ["TestArrayString"], url: "www.testurl.com", created: "testCreatedDate")
        let epArr = [newEp]
        evm.setArray(epArr)
        XCTAssertEqual(1, evm.getArrayCount())
    }
    
    func testGetIndex(){
        let newEp = Episodes(id: 1, name: "TestName", airDate: "TestAirDate", episode: "TestEpisode", characters: ["TestArrayString"], url: "www.testurl.com", created: "testCreatedDate")
        let newEp2 = Episodes(id: 1, name: "TestName2", airDate: "TestAirDate2", episode: "TestEpisode2", characters: ["TestArrayString2"], url: "www.testurl2.com", created: "testCreatedDate2")
        let epArr = [newEp, newEp2]
        evm.setArray(epArr)
        let indexVal = evm.getIndexOfArray(1)
        XCTAssertEqual(newEp2, indexVal)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
