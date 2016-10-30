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
    
    
    //MARK: - inserta una noticia nueva
    
    func insertNew(title:String, text:String, latitude:NSNumber, longitude:NSNumber, urlPhoto:String){
        
        let tableMS = client.table(withName: "Autors")
        
        tableMS.insert(["title" : title, "text": text, "latitude":latitude, "longitude":longitude, "urlPhoto":urlPhoto, "visible":false, "publicada":false]) { (result, error) in
            
            if let _ = error {
                print(error)
                return
            }
            
            print(result)
        }
        
        
    }
    
    
    //MARK: - Recibe el id de una noticia y la marca como publicada
    
    func publishNew(idnew:String){
        
        let tableMS = client.table(withName: "Autors")
        
        //let query = tableMS.query(with: NSPredicate(format: "id == '1c4885cd-51df-4cbc-ba3f-f780c9d559db'"))
        
        let query = tableMS.query(with: NSPredicate(format: "id contains[c] %@",idnew))
        
        query.read { (result, error) in
            
            if let _ = error {
                
                print(error)
                
                return;
            }else{
                
                print(result?.totalCount)
                
                if let items = result {
                    
                    
                    
                    for item in items.items! {
                        
                        var itemNew = item as! [String:AnyObject]
                        itemNew["publicada"] = 1 as AnyObject?
                        tableMS.update(itemNew, completion: { (result, error) in
                            
                            if let _ = error{
                                print(error)
                                return
                            }
                            
                            print(result)
                            
                        })
                    }
                    
                   
                    
                }

                
                
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
    func readAllItemsInTable(_ completion:@escaping (_ result:Any)->()) -> [Dictionary<String, AnyObject>] {
        
        let tableMS = client.table(withName: "Autors")
        var data: [Dictionary<String, AnyObject>]? = []
        
        
        tableMS.read { (results, error) in
            if let _ = error {
                print(error)
                return
            }
            
       
            
            if let items = results {
                
               
                
                for item in items.items! {
                    
                    data?.append(item as! [String:AnyObject])
                }
                
                completion(data)
                
            }
            
            
            
        }
        
        return data!
    }
    
    
    //MARK: - read table para usuarios - custom api
    
    func readNewPublished(_ completion:@escaping (_ result:Any)->()) {
        
        let tableMS = client.table(withName: "Autors")
        var data: [Dictionary<String, AnyObject>]? = []
        
        client.invokeAPI("readPublishedRecord", body: nil, httpMethod: "GET", parameters: nil, headers: nil,
                          completion: { ( results, response, error) in
                            
                            if let _ = error {
                                print(error)
                                return
                            }
                            
                            if let items = results {
  
                                for each in items as! [AnyObject] {
                                    
                                        data?.append(each as! [String:AnyObject])
        
                                }
                                

                                
                                completion(data)
                                
                            }
                            
                            
                            
                            
        })
    }
    
    
    
    func voteNew(idNew:String, vote:NSNumber){
       
        let tableMS = client.table(withName: "Voto")
        
        tableMS.insert(["idNew":idNew, "voto":vote]) { (result, error) in
            
            if let _ = error {
                print(error)
                return
            }
        }
        
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

