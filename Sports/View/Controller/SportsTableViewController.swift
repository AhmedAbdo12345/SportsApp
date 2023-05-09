//
//  SportsTableViewController.swift
//  Sports
//
//  Created by Ahmed on 02/05/2023.
//

import UIKit
import Kingfisher
import Reachability

protocol LeaguesProtocol{
    
    func getLeaguesFromApi(leaguesResponse: LeaguesResponse)
}


class SportsTableViewController: UITableViewController ,  LeaguesProtocol{
    var sportName = ""
   var leaguesResponse: LeaguesResponse?
    
    func getLeaguesFromApi(leaguesResponse: LeaguesResponse) {
        self.leaguesResponse = leaguesResponse
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.tableView.reloadData()

        }
        
    override func viewWillAppear(_ animated: Bool) {
        var  reachability = try! Reachability()
           var myNetworkConnection = MyNetworConnection(reachability: reachability)
             if myNetworkConnection.isReachableViaWiFi() {
              /*   NetworkService.fetchResult(sportName: sportName.lowercased()){
                     (res) in DispatchQueue.main.async {
                         
                         self.leaguesResponse = res
                         self.tableView.reloadData()
                         
                     }
                 }*/
                 var leaguesPresenter = LeaguesPresenter()
                 leaguesPresenter.getLeagues(sportName: sportName, view: self)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesResponse?.result?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)as! SportsTableViewCell
        

        if let url = URL(string: leaguesResponse?.result![indexPath.row].league_logo ?? "" ){
            cell.leagueImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder_leagues"))
            
        }else{
            switch sportName{
            case "Football": cell.leagueImage.image = UIImage(named: "football_img")
            case "Basketball": cell.leagueImage.image = UIImage(named: "basketball_img")
            case "Tennis": cell.leagueImage.image = UIImage(named: "tennis_img")
            default: cell.leagueImage.image = UIImage(named: "cricket_img")
            }
        }
      cell.leagueLabel.text = leaguesResponse?.result![indexPath.row].league_name


        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }

   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var  reachability = try! Reachability()
           var myNetworkConnection = MyNetworConnection(reachability: reachability)
             
      if myNetworkConnection.isReachableViaWiFi() {
          var detailsVC =  self.storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
          detailsVC.sportName = sportName
          detailsVC.leagueID = leaguesResponse?.result![indexPath.row].league_key
          self.navigationController?.pushViewController(detailsVC, animated: true)
          
        }else{
           let alert = UIAlertController(title: "Connection", message: "no found Internet Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive,handler: { [self] action in  }))
            
                self.present(alert, animated: true)
             }
    }
}
