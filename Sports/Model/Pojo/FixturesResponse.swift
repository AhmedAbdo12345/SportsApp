//
//  FixturesModel.swift
//  Sports
//
//  Created by Ahmed on 04/05/2023.
//

import Foundation


// MARK: - Welcome6
struct FixturesResponse :Decodable{
    let success: Int?
    let result: [FixturesModel]?
}

// MARK: - Result
struct FixturesModel : Decodable{
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_key: Int?
    let event_away_team: String?
    let away_team_key: Int?
    let event_halftime_rusult: String?
    let event_final_result: String?
    let event_ft_result:String?
    let event_penalty_result: String?
    let eventStatus: String?
    let country_name: String?
    let league_name: String?
    let league_key: Int?
    let league_round: String?
    let league_season:String?
    let event_live: String?
    let event_stadium: String?
    let event_referee: String?
    let home_team_logo:String?
    let away_team_logo: String?
    let event_country_key: Int?
    let league_logo: String?
    let country_logo: String?
    let event_home_formation:String?
    let event_away_formation: String?
    let fk_stage_key: Int?
    let stage_name: String?
    /*let league_group: NSNull*/
    
// ----------basketball Moel-------------------------
    let event_home_team_logo : String?
    let event_away_team_logo : String?
    let event_quarter : String?
//----------------------------------------------------------
//--------------Tennis--------------------------------------
    let event_first_player: String?
    let event_second_player: String?
    let first_player_key: Int?
    let second_player_key: Int?
    let event_first_player_logo: String?
    let event_second_player_logo: String?
    
    
 /*   let event_game_result: String?
    let event_serve: String?
    let event_winner: String?

    let pointbypoint: String?*/
    
//----------------------------------------------------------
//---------------Cricket-------------------------------------------

    
    
    
    
    
    

}

