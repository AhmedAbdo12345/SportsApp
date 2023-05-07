//
//  SportsModel.swift
//  Sports
//
//  Created by Ahmed on 04/05/2023.
//

import Foundation

struct LeaguesResponse : Decodable{
    let success: Int?
    let result: [LeaguesResult]?
}

struct LeaguesResult : Decodable{
    let league_key: Int?
    let league_name: String?
    let league_logo: String?
  
    
  /*  let country_logo: String?
    let league_year: String?
    let country_key: Int?
    let country_name: String?*/
}



