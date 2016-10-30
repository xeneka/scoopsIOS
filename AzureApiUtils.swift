//
//  AzureApiUtils.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 26/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation

class dataStackAzure{
    
    let client:MSClient
    
    init(){
        client = MSClient(applicationURL: URL(string: "https://abmscoops.azurewebsites.net")!)
    }
    
    
    func insertNew(title:String, text:String, latitude:NSNumber, longitude:NSNumber, urlPhoto:String){
        
        let tableMS = client.table(withName: "Autors")
        
        tableMS.insert(["title" : title, "text": text, "latitude":latitude, "longitude":longitude, "urlPhoto":urlPhoto, "visible":false]) { (result, error) in
            
            if let _ = error {
                print(error)
                return
            }
            
            print(result)
        }
        
        
    }
    
    
    
    
    
    
    
    func readAllItemsInTable(_ completion:@escaping (_ result:Any)->()) -> [Dictionary<String, AnyObject>] {
        
        let tableMS = client.table(withName: "Autors")
        var data: [Dictionary<String, AnyObject>]? = []
        
        //        let predicate = NSPredicate(format: "name == 'Juan Martin'")
        
        tableMS.read { (results, error) in
            if let _ = error {
                print(error)
                return
            }
            
//            if !((self.model?.isEmpty)!) {
//                self.model?.removeAll()
//            }
            
            
            
            if let items = results {
                
               
                
                for item in items.items! {
                    
                    data?.append(item as! [String:AnyObject])
                }
                
                completion(data)
                
            }
            
            
            
        }
        
        return data!
    }
    
    
    func login(provider: String, controller:UIViewController){
        
        client.login(withProvider: provider, controller: controller, animated: true) { (user, error) in
            
            if let _ = error {
                print("---",error)
                return
            }
            
            print("-+-",user?.userId)
           
            
        }
        
    }
    
    
    
    
    
}

