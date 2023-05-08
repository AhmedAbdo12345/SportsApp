//
//  DetailsNetworkService.swift
//  Sports
//
//  Created by Ahmed on 08/05/2023.
//

import Foundation

class DetailsNetworkService: FixtureNetworkProtocol,LiveScoreNetworkProtocol,TeamsNetworkProtocol{

    
    
    static func fetchResultFixtures(sportsName: String, leagueID: Int, dateFrom: Date, dateTo: Date, comlitionHandler: @escaping (FixturesResponse?) -> Void) {
        FixturesNetworkServices.fetchResultFixtures(sportsName: sportsName, leagueID: leagueID, dateFrom: dateFrom, dateTo: dateTo, comlitionHandler: comlitionHandler)
    }
    
    static func fetchResultLiveScore(sportsName: String, comlitionHandler: @escaping (LiveScoreResponse?) -> Void) {
        LiveScoreNetworkServices.fetchResultLiveScore(sportsName: sportsName, comlitionHandler: comlitionHandler)
    }
    
    static func fetchResultTeams(sportsName: String, teamID: Int, comlitionHandler: @escaping (TeamsResponse?) -> Void) {
        TeamsNetworkServices.fetchResultTeams(sportsName: sportsName, teamID: teamID, comlitionHandler: comlitionHandler)
    }
    


    
    
}
