//
//  MockLeaguesNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import Foundation
@testable import Sports
class MockLeaguesNetwork : NetworkProtocol{
    
    static  let leaguesResponse = ConstantJsonString.leaguesFootballJson
    
    static func fetchResult(sportName: String, comlitionHandler: @escaping (Sports.LeaguesResponse?) -> Void) {
        let data = Data(leaguesResponse.utf8)
        do{
            let res = try JSONDecoder().decode(LeaguesResponse.self, from: data)
            comlitionHandler(res)
        }catch let error{
            print(error.localizedDescription)
            comlitionHandler(nil)

        }
    }
    

  
}
