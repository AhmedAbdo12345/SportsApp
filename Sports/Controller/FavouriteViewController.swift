//
//  FavouriteViewController.swift
//  Sports
//
//  Created by Ahmed on 01/05/2023.
//

import UIKit
import Kingfisher
import CoreData

class FavouriteViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var favTable: UITableView!
    
    var myContext : NSManagedObjectContext!
    var favTeams : [TeamsModel] = []
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
            let url = URL(string: favTeams[indexPath.row].team_logo)
            cell.favTeamImage.kf.setImage(with: url)
        }
        cell.favTeamNameLabel.text = favTeams[indexPath.row].team_name
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favTable.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        myContext = appDelegate.persistentContainer.viewContext
        
         myCoreDate = MyCoreData(context: myContext)
        favTeams = myCoreDate.fechCoreData()
        
        favTable.reloadData()
        
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
}