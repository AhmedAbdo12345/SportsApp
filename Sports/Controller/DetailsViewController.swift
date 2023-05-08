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
    
    
    @IBOutlet weak var emptyFixtureImage: UIImageView!
    
    @IBOutlet weak var emptyTeamsImage: UIImageView!
    
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
            if sportName == "Football"{
                var teamDetailsVC =  self.storyboard?.instantiateViewController(withIdentifier: "teamsDetails") as! TeamsDetailsViewController
                
                teamDetailsVC.sportName = sportName
                teamDetailsVC.teamId = teamModel[indexPath.row].team_key!
                self.navigationController?.pushViewController(teamDetailsVC, animated: true)
            }else{
                
            let  alert = UIAlertController(title: "Message", message: "There is no Team Details for \(sportName)", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "Ok", style: .destructive,handler: { [self] action in
                }))
             
            self.present(alert, animated: true)
               
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        
        DetailsNetworkService.fetchResultFixtures(sportsName:sportName.lowercased(),leagueID:leagueID!, dateFrom: currentDate, dateTo:nextDate){
            (res) in DispatchQueue.main.async { [self] in
                
                self.fixturesResponse = res
                
                if res?.result != nil{
                    self.fixturesModel = (res?.result)!
                    
                }
                for fixture in fixturesModel{
                    fillTeamFromFixtures(fixture: fixture)
                }
                
                self.fixturesCollectionView.reloadData()
                self.teamsCollectionView.reloadData()
            }
        }
        
        DetailsNetworkService.fetchResultLiveScore(sportsName:sportName.lowercased()){
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
            if fixturesResponse?.result?.count ?? 0 == 0 {
                self.emptyFixtureImage.image = UIImage(named: "placeholder_empty")
                self.emptyFixtureImage.isHidden = false
                return  0
            }else{
                self.emptyFixtureImage.isHidden = true
            }
            return fixturesResponse?.result?.count ?? 0
        } else if collectionView == liveScoreCollectionView {
            return liveScoreResponse?.result?.count ?? 0
        } else {
            if fixturesResponse?.result?.count ?? 0 == 0 {
                self.emptyTeamsImage.image = UIImage(named: "placeholder_empty")
                self.emptyTeamsImage.isHidden = false
                return  0
            }else{
                self.emptyTeamsImage.isHidden = true
            }
            return teamModel.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == fixturesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! FixturesCollectionViewCell
            
        
      
            cell.dateLabel.text = fixturesResponse?.result![indexPath.row].event_date
            cell.timeLabel.text = fixturesResponse?.result![indexPath.row].event_time
            
            displayFixtureDataUI( fixtureModel: (fixturesResponse?.result![indexPath.row])!, cell: cell)
            
            return cell
        } else if collectionView == liveScoreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath)
            as! LivescoreCollectionViewCell
            
            cell.timeLabel.text = liveScoreResponse?.result![indexPath.row].event_time
            displayLiveScoreDataUI(liveScore: (liveScoreResponse?.result![indexPath.row])!, cell: cell)
 
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath) as! TeamsCollectionViewCell
            
            if let url = URL(string: teamModel[indexPath.row].team_logo ?? "") {
                cell.teamsImage.kf.setImage(with: url)
            }
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

    func displayFixtureDataUI(fixtureModel : FixturesModel, cell: FixturesCollectionViewCell){

        switch sportName{
            
        case "Football":
            if let urlHome = URL(string: fixtureModel.home_team_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Football"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Football")}
            if let urlAway = URL(string: fixtureModel.away_team_logo ?? ""){
                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named: "placeholder_Football"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Football")}

            cell.teamOneNameLabel.text = fixtureModel.event_home_team
            cell.teamTwoNameLabel.text = fixtureModel.event_away_team

            
        case "Basketball":
            if let urlHome = URL(string:  fixtureModel.event_home_team_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Basketball"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Basketball")}
            if let urlAway = URL(string:  fixtureModel.event_away_team_logo ?? ""){
                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named:"placeholder_Basketball"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Basketball")}
            cell.teamOneNameLabel.text = fixtureModel.event_home_team
            cell.teamTwoNameLabel.text = fixtureModel.event_away_team
        
        case "Tennis":
            if let urlHome = URL(string:fixtureModel.event_first_player_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Tennis"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Tennis")}
            if let urlAway = URL(string:fixtureModel.event_second_player_logo ?? ""){
                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named:"placeholder_Tennis"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Tennis")}
            cell.teamOneNameLabel.text = fixtureModel.event_first_player
            cell.teamTwoNameLabel.text = fixtureModel.event_second_player
        
            
        default:
            if let urlHome = URL(string: fixtureModel.home_team_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Cricket"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Cricket")}
            if let urlAway = URL(string: fixtureModel.away_team_logo ?? ""){
                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named:"placeholder_Cricket"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Cricket")}
            cell.teamOneNameLabel.text = fixtureModel.event_home_team
            cell.teamTwoNameLabel.text = fixtureModel.event_away_team
        
        }
    }
    

    func displayLiveScoreDataUI(liveScore : LiveScoreResult, cell: LivescoreCollectionViewCell){
        
        
        switch sportName{
            
        case "Football":
            
            if let urlHome = URL(string: liveScore.home_team_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Football"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Football")}
            if let urlAway = URL(string: liveScore.away_team_logo ?? ""){
                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named: "placeholder_Football"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Football")}
            
            cell.teamOneNameLabel.text = liveScore.event_home_team
            cell.teamTwoNameLabel.text = liveScore.event_away_team
            cell.dateLabel.text = liveScore.event_date
            cell.resultLabel.text = liveScore.event_final_result
            
            
        case "Basketball":
            if let urlHome = URL(string:  liveScore.event_home_team_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Basketball"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Basketball")}
            if let urlAway = URL(string:  liveScore.event_away_team_logo ?? ""){
                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named:"placeholder_Basketball"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Basketball")}
            cell.teamOneNameLabel.text = liveScore.event_home_team
            cell.teamTwoNameLabel.text = liveScore.event_away_team
            cell.dateLabel.text = liveScore.event_date
            cell.resultLabel.text = liveScore.event_final_result

            
            
        case "Tennis" :
            if let urlHome = URL(string:liveScore.event_first_player_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Tennis"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Tennis")}
            if let urlAway = URL(string:liveScore.event_second_player_logo ?? ""){                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named:"placeholder_Tennis"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Tennis")}
            cell.teamOneNameLabel.text = liveScore.event_first_player
            cell.teamTwoNameLabel.text = liveScore.event_second_player
            cell.dateLabel.text = liveScore.event_date
            cell.resultLabel.text = liveScore.event_final_result

            
            
        default:
            if let urlHome = URL(string: liveScore.event_home_team_logo ?? ""){
                cell.teamOneImage.kf.setImage(with: urlHome,placeholder: UIImage(named: "placeholder_Cricket"))
            }else{cell.teamOneImage.image = UIImage(named: "placeholder_Cricket")}
            if let urlAway = URL(string: liveScore.event_away_team_logo ?? ""){
                cell.teamTwoImage.kf.setImage(with: urlAway,placeholder: UIImage(named:"placeholder_Cricket"))
            }else{cell.teamTwoImage.image = UIImage(named: "placeholder_Cricket")}
            cell.teamOneNameLabel.text = liveScore.event_home_team
            cell.teamTwoNameLabel.text = liveScore.event_away_team
            cell.dateLabel.text = liveScore.event_date_start
            cell.resultLabel.text = liveScore.event_home_final_result?.appending(" - ").appending((liveScore.event_away_final_result!))

        }
    }
    
    func fillTeamFromFixtures(fixture:FixturesModel ){
        var teamHome : TeamsModel!
        var teamAway : TeamsModel!

        if fixture != nil{
            switch sportName{
                
            case "Football":
                if let key = fixture.home_team_key , let logo = fixture.home_team_logo{
                    teamHome = TeamsModel(team_key: key,team_name: fixture.event_home_team!,team_logo:logo)
                }
                if let key = fixture.away_team_key , let logo = fixture.away_team_logo{
                    teamAway = TeamsModel(team_key: key,team_name: fixture.event_away_team!,team_logo:logo)
                }
            case "Basketball" ,"Cricket":
                if let key = fixture.home_team_key , let logo = fixture.event_home_team_logo{
                    teamHome = TeamsModel(team_key: key,team_name: fixture.event_home_team!,team_logo:logo)  }
                if let key = fixture.away_team_key , let logo = fixture.event_away_team_logo{
                    teamAway = TeamsModel(team_key: key,team_name: fixture.event_away_team!,team_logo:logo)}
                
            default:
                if let key = fixture.first_player_key , let logo = fixture.event_first_player_logo{
                    teamHome = TeamsModel(team_key:key,team_name: fixture.event_first_player!,team_logo:logo) }
                if let key = fixture.second_player_key , let logo = fixture.event_second_player_logo{
                    teamAway = TeamsModel(team_key: key,team_name: fixture.event_second_player!,team_logo:logo) }
            }
            
            addTeamObject(team: teamHome)
            addTeamObject(team: teamAway)

        }
        
    }
 
    func addTeamObject(team : TeamsModel?){
        if !self.teamModel.contains(where: { $0.team_key == team?.team_key}){
            if  let team1 = team {
                self.teamModel.append(team1)
            }
        }
    }
}

