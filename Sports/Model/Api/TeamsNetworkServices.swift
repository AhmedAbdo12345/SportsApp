//
//  TeamsNetworkServices.swift
//  Sports
//
//  Created by Ahmed on 05/05/2023.
//

import Foundation
protocol TeamsNetworkProtocol{
    static func fetchResultTeams(sportsName:String,teamID:Int,comlitionHandler: @escaping (TeamsResponse?)-> Void)
    
}
class TeamsNetworkServices : TeamsNetworkProtocol{
 
    static func fetchResultTeams(sportsName:String,teamID:Int, comlitionHandler: @escaping (TeamsResponse?)-> Void) {
               
        var url = "https://apiv2.allsportsapi.com/\(sportsName)/?&met=Teams&teamId=\(teamID)&APIkey=243e9ed7ab60d0f2b0c1cbf0cf44824fce00282296cf3dfae234a42e399f03ba"

        guard let newUrl = URL(string: url) else{
            return
        }
        let req = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req){
            data , response, error in
            do{
                let res = try JSONDecoder().decode(TeamsResponse.self, from: data!)
                comlitionHandler(res)
            }catch let error{
                print(error.localizedDescription)
                comlitionHandler(nil)

            }
        }
        task.resume()
    }
}

