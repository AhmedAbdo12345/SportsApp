//
//  MyCoreData.swift
//  Sports
//
//  Created by Ahmed on 06/05/2023.
//

import Foundation
import CoreData
import UIKit

class MyCoreData{
    
    // obj ------contect---------Core Data
    var context : NSManagedObjectContext!
 
    
    init(context: NSManagedObjectContext!) {
        self.context = context
    }
   
    func saveCoreData(id: Int,teamName:String,image:String){

        let entity = NSEntityDescription.entity(forEntityName: "Team", in: context)
        
        let team = NSManagedObject(entity: entity!, insertInto: context)
        team.setValue(id, forKey: "id")
        team.setValue(teamName, forKey: "name")
        team.setValue(image, forKey: "image")
        
        do{
            try context?.save()
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }


    }
    
    func fechCoreData() -> [TeamsModel] {
        var arrTeam : [TeamsModel] = []
        var team : TeamsModel!


        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Team")
        do{
            var  arrTeams = try context.fetch(fetchReq)
            for model in arrTeams{
                team = TeamsModel(team_key: model.value(forKey: "id")! as! Int ,team_name: model.value(forKey: "name")! as! String,team_logo: model.value(forKey: "image")! as! String )
                
                
                arrTeam.append(team)
            }
            
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }
         return arrTeam
        
    }
    
    func deleteCoreData(name : String){
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Team")
        let predicate = NSPredicate(format: "name == %@", name)
        fetchReq.predicate = predicate
        do{
            var  teamObject = try context?.fetch(fetchReq)
            
            print(teamObject![0])
            try context.delete(teamObject![0])
            try context.save()
            
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        
    }
}
