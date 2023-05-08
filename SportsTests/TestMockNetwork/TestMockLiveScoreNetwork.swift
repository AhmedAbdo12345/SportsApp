//
//  TestMockLiveScoreNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest
@testable import Sports
final class TestMockLiveScoreNetwork: XCTestCase {
    
    func testFetchFootballLiveScoreFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        MockLiveScoreNetwork.fetchResultLiveScore(sportsName: "football"){
            res  in
            guard let liveScoreList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(liveScoreList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5)
        
    }}
