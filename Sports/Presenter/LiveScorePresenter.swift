//
//  LiveScorePresenter.swift
//  Sports
//
//  Created by Ahmed on 09/05/2023.
//

import Foundation

class LiveScorePresenter{
    
    func getLiveScore(sportName:String,view : DetailsProtocol){
        DetailsNetworkService.fetchResultLiveScore(sportsName:sportName.lowercased()){
            (res) in DispatchQueue.main.async {
                
                view.getLiveScoreFromApi(liveScoreResponse: res!)
            }
        }
    }
}
