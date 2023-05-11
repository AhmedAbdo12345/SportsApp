//
//  FixturesNetworkServices.swift
//  Sports
//
//  Created by Ahmed on 05/05/2023.
//

import Foundation
protocol FixtureNetworkProtocol{
    static func fetchResultFixtures(sportsName:String,leagueID:Int, dateFrom:Date ,dateTo:Date,comlitionHandler: @escaping (FixturesResponse?)-> Void)
    
}
class FixturesNetworkServices : FixtureNetworkProtocol{
 
    
    
    static func fetchResultFixtures(sportsName:String,leagueID:Int,  dateFrom:Date ,dateTo:Date,comlitionHandler: @escaping (FixturesResponse?)-> Void) {
        
        let stringDate = changeDateFormate(dateFrom:dateFrom,dateTo: dateTo)
        
        var url = "https://apiv2.allsportsapi.com/\(sportsName)/?met=Fixtures&APIkey=243e9ed7ab60d0f2b0c1cbf0cf44824fce00282296cf3dfae234a42e399f03ba&leagueId=\(leagueID)&from=\(stringDate.0)&to=\(stringDate.1)"
      
        guard let newUrl = URL(string: url) else{
            return
        }
        let req = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req){
            data , response, error in
            
            if let data = data {
                do{
                        let res = try JSONDecoder().decode(FixturesResponse.self, from: data)
                        comlitionHandler(res)
                }catch let error{
                    print(error.localizedDescription)
                    comlitionHandler(nil)

                }
            }else {
                print("Error: data object is nil")
            }
           
        }
        task.resume()
    }
    
    static func changeDateFormate(dateFrom:Date,dateTo: Date) -> (String,String){
        print(dateFrom)
        print(dateTo)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let fromDateString = dateFormatter.string(from: dateFrom)
        let toDateString = dateFormatter.string(from: dateTo)
        
        print(fromDateString)
        print(toDateString)
        return(fromDateString,toDateString)
    }
}
