//
//  MyNetworkConnection.swift
//  Sports
//
//  Created by Ahmed on 08/05/2023.
//

import Foundation
import Reachability
class MyNetworConnection{
    
   var reachability : Reachability!

    init(reachability: Reachability!) {
        self.reachability = reachability
    }
    
    
     func startReachability() {

        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
                do{
            try reachability.startNotifier()
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    @objc func reachabilityChanged(_ notification:Notification){
       // let reachability = notification.object as! Reachability

    }
    
    func isReachableViaWiFi() -> Bool {
        
        startReachability()
       if reachability.connection == .wifi {
           return true
       }else{
           return false
       }
   }
    
}
