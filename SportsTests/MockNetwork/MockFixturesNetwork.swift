//
//  MockFixturesNetwork.swift
//  SportsTests
//
//  Created by Ahmed on 07/05/2023.
//

import Foundation
@testable import Sports
class MockFixturesNetwork : FixtureNetworkProtocol{
    static  let fixtureResponse = ConstantJsonString.fixturesFootballJson

    static func fetchResult(sportsName: String, leagueID: Int, dateFrom: Date, dateTo: Date, comlitionHandler: @escaping (Sports.FixturesResponse?) -> Void) {
        let data = Data(fixtureResponse.utf8)
        do{
            let res = try JSONDecoder().decode(FixturesResponse.self, from: data)
            comlitionHandler(res)
        }catch let error{
            print(error.localizedDescription)
            comlitionHandler(nil)

        }
    }

 
}
