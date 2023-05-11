//
//  TestLeaguesNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest
@testable import Sports
final class TestLeaguesNetwork: XCTestCase {

    func testFetchFootballLeaguesFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        NetworkService.fetchResult(sportName: "football"){
            res  in
            guard let leaguesList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(leaguesList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        // I put timeout = 30 or 20 Because The Internet Connection in My House is very Week
        waitForExpectations(timeout: 50)
        
    }

    func testFetchBasketballLeaguesFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        NetworkService.fetchResult(sportName: "basketball"){
            res  in
            guard let leaguesList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(leaguesList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        // I put timeout = 30 or 20 Because The Internet Connection in My House is very Week
        waitForExpectations(timeout: 50)
        
    }
    func testFetchTennisLeaguesFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        NetworkService.fetchResult(sportName: "tennis"){
            res  in
            guard let leaguesList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(leaguesList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        // I put timeout = 30 or 20 Because The Internet Connection in My House is very Week
        waitForExpectations(timeout: 50)
        
    }
    func testFetchCricketLeaguesFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        NetworkService.fetchResult(sportName: "cricket"){
            res  in
            guard let leaguesList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(leaguesList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        // I put timeout = 30 or 20 Because The Internet Connection in My House is very Week
        waitForExpectations(timeout: 50)
        
    }
}
