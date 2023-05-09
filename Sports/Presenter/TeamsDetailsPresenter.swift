//
//  TeamsDetailsPresenter.swift
//  Sports
//
//  Created by Ahmed on 09/05/2023.
//

import Foundation

class TeamsDetailsPresenter{
    
    func getTeamDetails(sportName: String, teamId: Int, view :TeamsDetailsProtocol){
        DetailsNetworkService.fetchResultTeams(sportsName: sportName.lowercased(), teamID: teamId){
            (res) in DispatchQueue.main.async {
                
                view.getTeamsDetailsFromApi(teamsResponse: res!)                
                
            }
        }
    }
}
