//
//  FixturesNetworkServices.swift
//  Sports
//
//  Created by Ahmed on 05/05/2023.
//

import Foundation
protocol FixtureNetworkProtocol{
    static func fetchResult(sportsName:String,leagueID:Int, dateFrom:Date ,dateTo:Date,comlitionHandler: @escaping (FixturesResponse?)-> Void)
    
}
class FixturesNetworkServices : FixtureNetworkProtocol{
 
    
    
    static func fetchResult(sportsName:String,leagueID:Int,  dateFrom:Date ,dateTo:Date,comlitionHandler: @escaping (FixturesResponse?)-> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"

                let fromDateString = dateFormatter.string(from: dateFrom)
                let toDateString = dateFormatter.string(from: dateTo)
        
        var url = "https://apiv2.allsportsapi.com/\(sportsName)/?met=Fixtures&APIkey=243e9ed7ab60d0f2b0c1cbf0cf44824fce00282296cf3dfae234a42e399f03ba&leagueId=\(leagueID)&from=\(fromDateString)&to=\(toDateString)"
      
        guard let newUrl = URL(string: url) else{
            return
        }
        let req = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req){
            data , response, error in
            do{
                let res = try JSONDecoder().decode(FixturesResponse.self, from: data!)
                comlitionHandler(res)
            }catch let error{
                print(error.localizedDescription)
                comlitionHandler(nil)

            }
        }
        task.resume()
    }
}
