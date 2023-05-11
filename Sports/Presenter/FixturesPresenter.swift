//
//  FixturesPresenter.swift
//  Sports
//
//  Created by Ahmed on 09/05/2023.
//

import Foundation

class FixturesPresenter{
    
    func getFixtures(sportName:String,leaguesID: Int,view : DetailsProtocol){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 15, to: currentDate)!
        
        
        DetailsNetworkService.fetchResultFixtures(sportsName:sportName.lowercased(),leagueID:leaguesID, dateFrom: currentDate, dateTo:nextDate){
             (res) in DispatchQueue.main.async { [self] in
                 if let result = res {
                     view.getFixturesFromApi(fixturesResponse: result)

                 }
          
             }
         }
    }
    
 
}
