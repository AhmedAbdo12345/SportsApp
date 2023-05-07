//
//  TeamsModel.swift
//  Sports
//
//  Created by Ahmed on 05/05/2023.
//

import Foundation

/*struct TeamsResponse : Decodable{
    
    var result : [TeamsModel]?
}

struct TeamsModel:Decodable{
    
    var team_key: Int?
 //   var team_name: String?
    var team_logo: String?
}
*/

struct TeamsResponse : Decodable{
    let success :Int?
    let result : [TeamsModel]?
}

struct TeamsModel:Decodable{
    
    var team_key: Int!
    var team_name: String!
    var team_logo: String!
    var players: [Player]!
    
    init(team_key: Int,team_name: String ,team_logo: String){
        self.team_key = team_key
        self.team_name = team_name
        self.team_logo = team_logo

    }
    
}
struct Player: Decodable{
    let player_ket: Int?
    let player_name: String?
    let player_number: String?
    let player_country: String?
    let player_type: String?
    let player_age: String?
    let player_match_played: String?
    let player_goals: String?
    let player_yellow_cards: String?
    let player_red_cards: String?
    let player_image: String?
}
