//
//  FavouriteViewController.swift
//  Sports
//
//  Created by Ahmed on 01/05/2023.
//

import UIKit
import Kingfisher
import CoreData
import Reachability
class FavouriteViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var favTable: UITableView!
    
    var myContext : NSManagedObjectContext!
    var favTeams : [TeamModelCoreData] = []
    var myCoreDate: MyCoreData!
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favTeams.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)as! FavTableViewCell
        
        if favTeams[indexPath.row].team_logo != nil {
          /*  let url = URL(string: favTeams[indexPath.row].team_logo)
            cell.favTeamImage.kf.setImage(with: url)*/
            
            let imageString = favTeams[indexPath.row].team_logo
            cell.favTeamImage.image = UIImage(data: imageString!)
            
        }
        
        
        
        cell.favTeamNameLabel.text = favTeams[indexPath.row].team_name
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        myContext = appDelegate.persistentContainer.viewContext
        
         myCoreDate = MyCoreData(context: myContext)
        favTeams = myCoreDate.fechCoreData()
        
        favTable.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        favTable.reloadData()
        
    }
    
    @objc func reachabilityChanged(_ notification:Notification){
        let reachability = notification.object as! Reachability
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete", message: "Do you want to Delete this Item ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive,handler: { [self] action in
            
            myCoreDate.deleteCoreData(name: favTeams[indexPath.row].team_name)
            favTeams.remove(at: indexPath.row)
            self.favTable.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel,handler: { action in
            
        }))
                    
    self.present(alert, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   var  reachability = try! Reachability()
      var myNetworkConnection = MyNetworConnection(reachability: reachability)
        
        if myNetworkConnection.isReachableViaWiFi() {
            var teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "teamsDetails") as! TeamsDetailsViewController
                    
                    teamDetailsVC.sportName = "Football"
                    teamDetailsVC.teamId = favTeams[indexPath.row].team_key
                    self.navigationController?.pushViewController(teamDetailsVC, animated: true)
        }else{
            let alert = UIAlertController(title: "Connection", message: "no found Internet Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive,handler: { [self] action in  }))
           self.present(alert, animated: true)
        }

    }
 
    
}
