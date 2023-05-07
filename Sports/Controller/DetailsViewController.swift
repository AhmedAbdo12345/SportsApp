//
//  DetailsViewController.swift
//  Sports
//
//  Created by Ahmed on 02/05/2023.
//

import UIKit

class DetailsViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var fixturesResponse: FixturesResponse?
    var liveScoreResponse: LiveScoreResponse?
    var teamsResponse : TeamsResponse?
    var fixturesModel : [FixturesModel] = []
    var teamModel : [TeamsModel] = []
    var leagueID: Int?
    var sportName = ""
    
    @IBOutlet weak var fixturesCollectionView: UICollectionView!
    
    @IBOutlet weak var liveScoreCollectionView: UICollectionView!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.fixturesCollectionView.reloadData()
        self.liveScoreCollectionView.reloadData()
        self.teamsCollectionView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
            var teamDetailsVC =  self.storyboard?.instantiateViewController(withIdentifier: "teamsDetails") as! TeamsDetailsViewController
            
            teamDetailsVC.sportName = sportName
            teamDetailsVC.teamId = teamModel[indexPath.row].team_key
            
            self.navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        
        FixturesNetworkServices.fetchResult(sportsName:sportName.lowercased(),leagueID:leagueID!, dateFrom: currentDate, dateTo:nextDate){
            (res) in DispatchQueue.main.async { [self] in
                
                self.fixturesResponse = res
                
                if res?.result != nil{
                    self.fixturesModel = (res?.result)!
                    
                }
                for fixture in fixturesModel{
                    fillTeamFromFixtures(sportsName: sportName, fixture: fixture, teamType: "home")
                    fillTeamFromFixtures(sportsName: sportName, fixture: fixture, teamType: "away")
                }
                
                self.fixturesCollectionView.reloadData()
                self.teamsCollectionView.reloadData()
                
            }
        }
        
        LiveScoreNetworkServices.fetchResult(sportsName:sportName.lowercased(),leagueID:leagueID!){
            (res) in DispatchQueue.main.async {
                
                self.liveScoreResponse = res
                self.liveScoreCollectionView.reloadData()
                
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == fixturesCollectionView {
            return fixturesResponse?.result?.count ?? 0
        } else if collectionView == liveScoreCollectionView {
            return liveScoreResponse?.result?.count ?? 0
        } else {
            return teamModel.count ?? 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath)
        if collectionView == fixturesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! FixturesCollectionViewCell
            cell.dateLabel.text = fixturesResponse?.result![indexPath.row].event_date
            cell.timeLabel.text = fixturesResponse?.result![indexPath.row].event_time
            
            displayFixtureDataUI(sportsName: sportName, fixtureModel: (fixturesResponse?.result![indexPath.row])!, cell: cell, teamType: "home")
            displayFixtureDataUI(sportsName: sportName, fixtureModel: (fixturesResponse?.result![indexPath.row])!, cell: cell, teamType: "away")

            
            return cell
        } else if collectionView == liveScoreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath)
            as! LivescoreCollectionViewCell
            
            cell.dateLabel.text = liveScoreResponse?.result![indexPath.row].event_date
            cell.timeLabel.text = liveScoreResponse?.result![indexPath.row].event_time
            
            displayLiveScoreDataUI(sportsName: sportName, liveScore: (liveScoreResponse?.result![indexPath.row])!, cell: cell, teamType: "home")
            displayLiveScoreDataUI(sportsName: sportName, liveScore: (liveScoreResponse?.result![indexPath.row])!, cell: cell, teamType: "away")
 
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath) as! TeamsCollectionViewCell
            
            let url = URL(string: teamModel[indexPath.row].team_logo!)
            cell.teamsImage.kf.setImage(with: url)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == teamsCollectionView {
            let width = collectionView.bounds.width/3
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        }else{
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        }
    }
    
    
   /* func displayFixturesImage(urlName : String!, image: UIImageView) {
        
        if urlName != nil{
            let url = URL(string: urlName)
            image.kf.setImage(with: url)
        }
    }*/
    

    func displayFixtureDataUI(sportsName:String,fixtureModel : FixturesModel, cell: FixturesCollectionViewCell , teamType: String){
        var url : String! = ""
        
        switch sportsName{
            
        case "Football":  if teamType == "home" {
            url = fixtureModel.home_team_logo
            cell.teamOneNameLabel.text = fixtureModel.event_home_team
        }
            else {url = fixtureModel.away_team_logo
                cell.teamTwoNameLabel.text = fixtureModel.event_away_team
            }
            
        case "Basketball":  if teamType == "home" {url = fixtureModel.event_home_team_logo
            cell.teamOneNameLabel.text = fixtureModel.event_home_team
        }else {url = fixtureModel.event_away_team_logo
            cell.teamTwoNameLabel.text = fixtureModel.event_away_team
        }
            
        case "Tennis":  if teamType == "home" {url = fixtureModel.event_first_player_logo
            cell.teamOneNameLabel.text = fixtureModel.event_first_player
        }else {url = fixtureModel.event_second_player_logo
            cell.teamTwoNameLabel.text = fixtureModel.event_second_player
        }
            
        default:  if teamType == "home" {url = fixtureModel.home_team_logo
            cell.teamOneNameLabel.text = fixtureModel.event_home_team

        }else {url = fixtureModel.away_team_logo
            cell.teamTwoNameLabel.text = fixtureModel.event_away_team
        }
        }
        
        
        if let newUrl = url , let myUrl = URL(string: newUrl){
            if teamType == "home"{
                cell.teamOneImage.kf.setImage(with: myUrl)
            }else{
                cell.teamTwoImage.kf.setImage(with: myUrl)
            }
        }
        
    }
    
    func displayLiveScoreDataUI(sportsName:String,liveScore : LiveScoreResult, cell: LivescoreCollectionViewCell , teamType: String){
        var url : String! = ""
        
        switch sportsName{
            
        case "Football":  if teamType == "home" {
            url = liveScore.home_team_logo
            cell.teamOneNameLabel.text = liveScore.event_home_team
        }
            else {url = liveScore.away_team_logo
                cell.teamTwoNameLabel.text = liveScore.event_away_team
            }
            
        case "Basketball":  if teamType == "home" {url = liveScore.event_home_team_logo
            cell.teamOneNameLabel.text = liveScore.event_home_team
        }else {url = liveScore.event_away_team_logo
            cell.teamTwoNameLabel.text = liveScore.event_away_team
        }
            
        case "Tennis":  if teamType == "home" {url = liveScore.event_first_player_logo
            cell.teamOneNameLabel.text = liveScore.event_first_player
        }else {url = liveScore.event_second_player_logo
            cell.teamTwoNameLabel.text = liveScore.event_second_player
        }
            
        default:  if teamType == "home" {url = liveScore.event_home_team_logo
            cell.teamOneNameLabel.text = liveScore.event_home_team

        }else {url = liveScore.event_away_team_logo
            cell.teamTwoNameLabel.text = liveScore.event_away_team
        }
        }
        
        
        if let newUrl = url , let myUrl = URL(string: newUrl){
            if teamType == "home"{
                cell.teamOneImage.kf.setImage(with: myUrl)
            }else{
                cell.teamTwoImage.kf.setImage(with: myUrl)
            }
        }
        
    }

    
    
    
    
    func fillTeamFromFixtures(sportsName: String , fixture:FixturesModel , teamType:String ){
        var team : TeamsModel!
        if fixture != nil{
            switch sportsName{
                
            case "Football":  if teamType == "home" {
                team = TeamsModel(team_key: fixture.home_team_key!,team_name: fixture.event_home_team!,team_logo:fixture.home_team_logo!)
                
            }else {    team = TeamsModel(team_key: fixture.away_team_key!,team_name: fixture.event_away_team!,team_logo:fixture.away_team_logo!)}
                
            case "Basketball" ,"Cricket":  if teamType == "home" {
                team = TeamsModel(team_key: fixture.home_team_key!,team_name: fixture.event_home_team!,team_logo:fixture.event_home_team_logo!)
                
            }else {    team = TeamsModel(team_key: fixture.away_team_key!,team_name: fixture.event_away_team!,team_logo:fixture.event_away_team_logo!)}
                
            default: if teamType == "home" {
                team = TeamsModel(team_key: fixture.home_team_key!,team_name: fixture.event_first_player!,team_logo:fixture.event_first_player_logo!)
                
            }else {    team = TeamsModel(team_key: fixture.away_team_key!,team_name: fixture.event_second_player!,team_logo:fixture.event_second_player_logo!)}
            }
            
            if !self.teamModel.contains(where: { $0.team_key == team.team_key }) {
                self.teamModel.append(team)
            }
        }
        
    }
    
}

