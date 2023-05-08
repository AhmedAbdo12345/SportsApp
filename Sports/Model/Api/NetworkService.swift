//
//  NetworkService.swift
//  Sports
//
//  Created by Ahmed on 04/05/2023.
//

import Foundation
protocol NetworkProtocol{
    static func fetchResult( sportName:String,comlitionHandler: @escaping (LeaguesResponse?)-> Void)
    
}
class NetworkService : NetworkProtocol{
    
    static func fetchResult( sportName:String ,comlitionHandler: @escaping (LeaguesResponse?)-> Void) {
        
        var url = "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=243e9ed7ab60d0f2b0c1cbf0cf44824fce00282296cf3dfae234a42e399f03ba"
      
        guard let newUrl = URL(string: url) else{
            return
        }
        let req = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req){
            data , response, error in
            do{
                let res = try JSONDecoder().decode(LeaguesResponse.self, from: data!)
                comlitionHandler(res)
            }catch let error{
                print(error.localizedDescription)
                comlitionHandler(nil)

            }
        }
        task.resume()
    }
}
