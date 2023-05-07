//
//  MockTeamsNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//


import Foundation
@testable import Sports
class MockTeamsNetwork : TeamsNetworkProtocol{
    
    static  let teamsResponse = ConstantJsonString.teamsFootballJson
    
    static func fetchResult(sportsName: String, teamID: Int, comlitionHandler: @escaping (Sports.TeamsResponse?) -> Void) {
        let data = Data(teamsResponse.utf8)
        do{
            let res = try JSONDecoder().decode(TeamsResponse.self, from: data)
            comlitionHandler(res)
        }catch let error{
            print(error.localizedDescription)
            comlitionHandler(nil)

        }
    }

}
