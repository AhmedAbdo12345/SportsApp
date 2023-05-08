//
//  TestMockTeamsNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest
@testable import Sports

final class TestMockTeamsNetwork: XCTestCase {

        func testFetchFootballTeamsFromAPI()  {
            let expectaion = expectation(description: "waiting for the API")
            MockTeamsNetwork.fetchResultTeams(sportsName: "football", teamID: 4){
                res  in
                guard let teamsList = res else{
                    XCTFail()
                    expectaion.fulfill()
                    return
                }
                XCTAssertNotEqual(teamsList.result?.count, 0,"API Failed")
                expectaion.fulfill()
            }
            waitForExpectations(timeout: 5)
            
        }


    }
