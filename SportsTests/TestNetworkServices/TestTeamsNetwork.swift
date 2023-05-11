//
//  TestTeamsNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest
@testable import Sports

final class TestTeamsNetwork: XCTestCase {

    func testFetchFootballTeamsFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        TeamsNetworkServices.fetchResultTeams(sportsName: "football", teamID: 4){
            res  in
            guard let teamsList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(teamsList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        // I put timeout = 30 or 20 Because The Internet Connection in My House is very Week
        waitForExpectations(timeout: 20)
        
    }


}
