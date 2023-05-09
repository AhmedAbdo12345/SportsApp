//
//  TeamsDetailsViewController.swift
//  Sports
//
//  Created by Ahmed on 06/05/2023.
//

import UIKit
import Kingfisher
import CoreData

protocol TeamsDetailsProtocol{
    func getTeamsDetailsFromApi(teamsResponse: TeamsResponse)
}


class TeamsDetailsViewController: UIViewController , UITableViewDelegate,UITableViewDataSource , TeamsDetailsProtocol{
    
    
    var myContext : NSManagedObjectContext!
    var sportName = ""
    var teamId = 0
    var teamsResponse: TeamsResponse!
    
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var playersTable: UITableView!
    

    @IBAction func favButton(_ sender: UIButton) {
        if teamsResponse != nil {
            var image : Data!
            var myCoreDate = MyCoreData(context: myContext)
            if teamImage.image != nil {
             image = teamImage.image?.pngData()
            }
            myCoreDate.saveCoreData(id: teamId, teamName: teamsResponse.result![0].team_name, image: image)
       
            
        let  alert = UIAlertController(title: "Saved", message: "Team Add SuccessFully in Favourite", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .destructive,handler: { [self] action in
            
            }))
         
        self.present(alert, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if sportName == "Football"{
            
           var teamsPresenter = TeamsDetailsPresenter()
            teamsPresenter.getTeamDetails(sportName: sportName, teamId: teamId, view: self)
       
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        myContext = appDelegate.persistentContainer.viewContext
        
        self.playersTable.reloadData()
        }
    
    func getTeamsDetailsFromApi(teamsResponse: TeamsResponse) {
        self.teamsResponse = teamsResponse

        self.teamNameLabel.text = teamsResponse.result![0].team_name
        
        if let url = teamsResponse.result![0].team_logo ,let url = URL(string: url){
            self.teamImage.kf.setImage(with: url)
        }
        self.playersTable.reloadData()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsResponse?.result![0].players.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayersTableViewCell
        
        if let url = teamsResponse?.result![0].players[indexPath.row].player_image ,
           let url = URL(string: url){
            cell.playerImage.kf.setImage(with: url, options: [.processor(RoundCornerImageProcessor(cornerRadius:  cell.playerImage.frame.width/2))])
            cell.playerImage.layer.cornerRadius =  cell.playerImage.frame.width/2
            cell.playerImage.clipsToBounds = true
            
        }
        cell.playerNameLabel.text = teamsResponse?.result![0].players[indexPath.row].player_name
        cell.playerNumberLabel.text = teamsResponse?.result![0].players[indexPath.row].player_number

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150

    }
}
