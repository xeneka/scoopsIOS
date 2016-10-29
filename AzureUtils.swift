//
//  AzureUtils.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 24/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation



func setupClientForStorage() -> AZSCloudStorageAccount?{
    
        do{
            let sas = "sv=2015-04-05&ss=bfqt&srt=sco&sp=rwdlacup&se=2016-10-25T17:14:23Z&st=2016-10-25T09:14:23Z&spr=https&sig=Qdhs0oMhAjuar4EPi9k%2FOZSJsJXKeQ0baVhsvhHCNcM%3D"
            let accountName = "abmpracticaazure"
            
            let credentials = AZSStorageCredentials(sasToken: sas, accountName: accountName)
            
            let account = try AZSCloudStorageAccount(credentials: credentials, useHttps: true)
            
            
          
            return account
            
        }catch let error{
            print(error)
        }
        
        return nil
    
}

func createNewContainer(nameContaniner name:String, blobClient account:AZSCloudStorageAccount ) -> AZSCloudBlobContainer?{
    
  
    
    //Obtengo el cliente
    
    let client = account.getBlobClient()
    
    //Comprobar si existe el container
    
    let blobContainer = client?.containerReference(fromName: name)
    
    blobContainer?.createContainerIfNotExists(with: AZSContainerPublicAccessType.container, requestOptions: nil, operationContext: nil, completionHandler: { (error, result) in
        
        guard let _ = error else{
            print(error)
           
            return
        }
        
        
    })
    
    
    return blobContainer
    
    
}


func upLoadBlobWithSAS(container: AZSCloudBlobContainer, data:Data) -> String{
    
    var blobName = UUID().uuidString
    
    let blog = container.blockBlobReference(fromName: blobName)
    
    blog.upload(from: data) { (error) in
        
       
        if error != nil {
            blobName = ""
            return
        }
        
        
    }
    
    return blobName
    
}

func eraseBlobBlock(_ theBlob: AZSCloudBlockBlob) {
    
    theBlob.delete { (error) in
        
        if let _ = error {
            print(error)
            return
        }
        
       
        
    }
}



func readAllBlobs(container: AZSCloudBlobContainer)  {
    
    var itemBlob = [AZSCloudBlockBlob]()
    
    container.listBlobsSegmented(with: nil,
                                  prefix: nil,
                                  useFlatBlobListing: true,
                                  blobListingDetails: AZSBlobListingDetails.all,
                                  maxResults: -1,
                                  completionHandler: { (error, results) in
                                    
                                    if let _ = error {
                                        print(error)
                                        return
                                    }
                                    
                                    
                                    
                                    for items in (results?.blobs)! {
                                        itemBlob.append(items as! AZSCloudBlockBlob)
                                    }
                                    
                                   
    })
    
}

func downloadBlobFromStorage(_ theBlob: AZSCloudBlockBlob) -> Data {
    
    var dataBlog:Data?
    
    theBlob.downloadToData { (error, data) in
        
        if let _ = error {
            print(error)
            return
        }
        
        dataBlog = data
        
    }

    return dataBlog!
}




