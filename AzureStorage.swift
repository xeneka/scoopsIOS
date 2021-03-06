//
//  AzureStorage.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 29/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation

class AzureStorage{
    
    static let sas = "sv=2015-04-05&ss=bfqt&srt=sco&sp=rwdlacup&se=2016-11-01T17:54:03Z&st=2016-11-01T09:54:03Z&spr=https&sig=KT7PkTnK1cf0bsPGLy41mTJCsUjKnB%2BZGMxlG3w8TsM%3D"
    
    static let accountName = "abmpracticaazure"
    
    static let blobContainer = "abmscoops"
    
    let credentials:AZSStorageCredentials
    
    let account:AZSCloudStorageAccount
    
    init(){
        
        credentials = AZSStorageCredentials(sasToken: AzureStorage.sas, accountName: AzureStorage.accountName)
        account = try! AZSCloudStorageAccount(credentials: credentials, useHttps: true)
        
    }
    
    
    //MARK: - Devuelve el id del contenedor o lo crea si no existe
    
    func createNewContainer() -> AZSCloudBlobContainer?{
        
        //Obtengo el cliente
        
        let client = account.getBlobClient()
        
        //Comprobar si existe el container
        
        let blobContainer = client?.containerReference(fromName: AzureStorage.blobContainer)
        
        blobContainer?.createContainerIfNotExists(with: AZSContainerPublicAccessType.container, requestOptions: nil, operationContext: nil, completionHandler: { (error, result) in
            
            guard let _ = error else{
                print(error)
                
                return
            }
            
        })
        
        
        return blobContainer
        
        
    }

    //MARK: - Sube un Blob
    
    func upLoadBlobWithSAS(data:Data, nameFile: String){
        
        
        
        let container = createNewContainer()
        
        let blog = container?.blockBlobReference(fromName: nameFile )
        
        blog?.upload(from: data) { (error) in
            
            
            if error != nil {
                print(error)
                return
            }
            
            
        }
        
       
        
    }
    
    
    //MARK: - descarga blob
    
    func downloadBlobFromStorage(nameFile:String, completion:@escaping (_ result:Any)->() ) {
        

        let container = createNewContainer()
        
        
        
        let theBlob = container?.blockBlobReference(fromName: nameFile )
        
        var dataBlog:Data?
        
        theBlob?.downloadToData { (error, data) in
            
            if let _ = error {
               // print(error)
                return
            }
            
            completion(data)
            dataBlog = data
            
        }
        
        
    }

    

    
    
}
