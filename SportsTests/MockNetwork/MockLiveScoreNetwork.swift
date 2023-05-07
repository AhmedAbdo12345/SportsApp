//
//  MockLiveScoreNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import Foundation
@testable import Sports
class MockLiveScoreNetwork : LiveScoreNetworkProtocol{
    
    static  let liveScopeResponse = ConstantJsonString.liveScoreFootballJson
    
    static func fetchResult(sportsName: String, comlitionHandler: @escaping (Sports.LiveScoreResponse?) -> Void) {
        let data = Data(liveScopeResponse.utf8)
        do{
            let res = try JSONDecoder().decode(LiveScoreResponse.self, from: data)
            comlitionHandler(res)
        }catch let error{
            print(error.localizedDescription)
            comlitionHandler(nil)

        }
    }
 
}
