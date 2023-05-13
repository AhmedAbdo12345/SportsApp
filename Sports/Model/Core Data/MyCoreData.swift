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
    
       var context : NSManagedObjectContext!
     private static var instantCoreData : MyCoreData!
    
    
    private init(){
        
    }
    func sendContextToCoreData(context: NSManagedObjectContext!){
        self.context = context
    }
    
  static  func getInstantCoreData() -> MyCoreData{
      if instantCoreData != nil{
            return instantCoreData
        }else{
            instantCoreData = MyCoreData()
        return instantCoreData
        }
    }
    

    func saveCoreData(id: Int,teamName:String,image: Data){
        //--------------------------------------------
        if  fetchTeam(teamKey:id) == nil{
            let entity = NSEntityDescription.entity(forEntityName: "Team", in: context)
            
            let team = NSManagedObject(entity: entity!, insertInto: context)
            
            team.setValue(id, forKey: "id")
            team.setValue(teamName, forKey: "name")
            
            if image != nil{
                team.setValue(image, forKey: "image")
            }
            
            do{
                try context?.save()
                
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    
    func fechCoreData() -> [TeamModelCoreData] {
     var arrTeam : [TeamModelCoreData] = []
        var team : TeamModelCoreData!

        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Team")
        do{
            var  arrTeams = try context.fetch(fetchReq)
            var imageString = ""
            for model in arrTeams{
    
                team = TeamModelCoreData(team_key: model.value(forKey: "id")! as! Int ,team_name: model.value(forKey: "name")! as! String,team_logo: model.value(forKey: "image")! as? Data)
                
                
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
    
    func fetchTeam(teamKey: Int) -> NSManagedObject? {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Team")
            let predicate = NSPredicate(format: "id == %d", teamKey)
            fetchRequest.predicate = predicate
            do {
                let teams = try context?.fetch(fetchRequest)
                return teams?.first
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
}
