//
//  TestFixturesNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest
@testable import Sports

final class TestFixturesNetwork: XCTestCase {

    var currentDate : Date!
    var  nextDate : Date!
    
    override func setUpWithError() throws {
         currentDate = Date()
         nextDate = Calendar.current.date(byAdding: .day, value: 15, to: currentDate)!
    }
    
   func testFetchFootballFixturesFromAPI()  {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd"
   
       
        let expectaion = expectation(description: "waiting for the API")
        FixturesNetworkServices.fetchResultFixtures(sportsName: "football", leagueID: 4, dateFrom: currentDate, dateTo: nextDate){
            res  in
            guard let fixturesList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(fixturesList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
       // I put timeout = 30 or 20 Because The Internet Connection in My House is very Week
        waitForExpectations(timeout: 30, handler: nil)
        
    }
    func testFetchFootballFixturesFromAPICheckResponsIsNil()  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        
         let expectaion = expectation(description: "waiting for the API")
        FixturesNetworkServices.fetchResultFixtures(sportsName: "football", leagueID: -1, dateFrom: currentDate, dateTo: nextDate){
             res  in
             guard let fixturesList = res else{
                 XCTFail()
                 expectaion.fulfill()
                 return
             }
            XCTAssertNil(res?.result)
             expectaion.fulfill()
         }
        // I put timeout = 30 or 20 Because The Internet Connection in My House is very Week
         waitForExpectations(timeout: 30, handler: nil)
         
     }
   func testFetchBasketballlFixturesFromAPI()  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        
         let expectaion = expectation(description: "waiting for the API")
         FixturesNetworkServices.fetchResultFixtures(sportsName: "basketball", leagueID: 4, dateFrom: currentDate, dateTo: nextDate){
             res  in
             guard let fixturesList = res else{
                 XCTFail()
                 expectaion.fulfill()
                 return
             }
             XCTAssertNotEqual(fixturesList.result?.count, 0,"API Failed")
             expectaion.fulfill()
         }
       // I put timeout = 30 or 20 Because The Internet Connection in My home is very Week
         waitForExpectations(timeout: 30)
         
     }
    
    func testChangeDateFormateMethod()  {
        // Given
        let dateFormatter = DateFormatter()
      
        // When
       let dateFormate = FixturesNetworkServices.changeDateFormate(dateFrom: currentDate, dateTo: nextDate)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let firstDate = dateFormate.0
        let secondDate = dateFormate.1
        
        // Then
        XCTAssertEqual(dateFormate.0, firstDate,"Date Formate Failed")
        XCTAssertEqual(dateFormate.1, secondDate,"Date Formate Failed")


     }
}
