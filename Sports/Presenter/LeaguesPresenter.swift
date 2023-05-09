//
//  LeaguesPresenter.swift
//  Sports
//
//  Created by Ahmed on 09/05/2023.
//

import Foundation

class LeaguesPresenter{
    
    func getLeagues(sportName:String,view : LeaguesProtocol){
            NetworkService.fetchResult(sportName: sportName.lowercased()){
                (res) in DispatchQueue.main.async {
                    
                    view.getLeaguesFromApi(leaguesResponse:res!)
                    
                }
            }
        
    }
}
