//
//  TestMockLeaguesNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest

@testable import Sports

final class TestMockLeaguesNetwork: XCTestCase {

    func testFetchFootballLeaguesFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        MockLeaguesNetwork.fetchResult(sportName: "football"){
            res  in
            guard let leaguesList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(leaguesList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5)
        
    }

    }
