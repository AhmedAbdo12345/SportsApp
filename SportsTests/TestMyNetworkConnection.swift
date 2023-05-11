//
//  TestMyNetworkConnection.swift
//  SportsTests
//
//  Created by Ahmed on 11/05/2023.
//

import XCTest
@testable import Reachability
@testable import Sports
final class TestMyNetworkConnection: XCTestCase {
    var reachability : Reachability!
    var myNetworkConnection : MyNetworConnection!
     override func setUpWithError() throws {
           reachability = try! Reachability()
          myNetworkConnection = MyNetworConnection(reachability: reachability)
         
     }

     override func tearDownWithError() throws {
         reachability = nil
         myNetworkConnection = nil
     }

     func testtoCheckInternetConnection() throws {
         // Given
         var  reachability = try! Reachability()
         var myNetworkConnection = MyNetworConnection(reachability: reachability)
              
         // When
         var result = myNetworkConnection.isReachableViaWiFi()
         
         // Then
         XCTAssertTrue(result)
         
     }

   
 }

