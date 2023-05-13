//
//  TestLiveScoreNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import XCTest
@testable import Sports

final class TestLiveScoreNetwork: XCTestCase {
    
    func testFetchFootballLiveScoreFromAPI()  {
        let expectaion = expectation(description: "waiting for the API")
        LiveScoreNetworkServices.fetchResultLiveScore(sportsName: "football"){
            res  in
            guard let liveScoreList = res else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(liveScoreList.result?.count, 0,"API Failed")
            expectaion.fulfill()
        }
        // I put timeout = 30 or 20 Because The Internet Connection in My home is very Week
        waitForExpectations(timeout: 30)
        
    }

}
