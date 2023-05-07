//
//  LiveScoreNetworkServices.swift
//  Sports
//
//  Created by Ahmed on 05/05/2023.
//

import Foundation
protocol LiveScoreNetworkProtocol{
    static func fetchResult(sportsName:String,leagueID:Int,comlitionHandler: @escaping (LiveScoreResponse?)-> Void)
    
}
class LiveScoreNetworkServices : LiveScoreNetworkProtocol{
 
    
    
    static func fetchResult(sportsName:String,leagueID:Int, comlitionHandler: @escaping (LiveScoreResponse?)-> Void) {
               
        var url = "https://apiv2.allsportsapi.com/\(sportsName)/?met=Livescore&APIkey=243e9ed7ab60d0f2b0c1cbf0cf44824fce00282296cf3dfae234a42e399f03ba"
      
        guard let newUrl = URL(string: url) else{
            return
        }
        let req = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req){
            data , response, error in
            do{
                let res = try JSONDecoder().decode(LiveScoreResponse.self, from: data!)
                comlitionHandler(res)
            }catch let error{
                print(error.localizedDescription)
                comlitionHandler(nil)

            }
        }
        task.resume()
    }
}
