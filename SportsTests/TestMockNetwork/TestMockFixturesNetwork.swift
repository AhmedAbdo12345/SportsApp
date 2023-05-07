//
//  TestMockFixturesNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest

@testable import Sports
final class TestMockFixturesNetwork: XCTestCase {

    func testFetchFootballFixturesFromAPI()  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        
         let expectaion = expectation(description: "waiting for the API")
         MockFixturesNetwork.fetchResult(sportsName: "football", leagueID: 4, dateFrom: currentDate, dateTo: nextDate){
             res  in
             guard let fixturesList = res else{
                 XCTFail()
                 expectaion.fulfill()
                 return
             }
             XCTAssertNotEqual(fixturesList.result?.count, 0,"API Failed")
             expectaion.fulfill()
         }
         waitForExpectations(timeout: 5)
         
     }
 }

        
