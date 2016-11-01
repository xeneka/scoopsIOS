//
//  AutorsViewModel.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 29/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation


final class noteViewModel{
    
    var model:dataNews
    let stackAzure:dataStackAzure
    
    init(title:String, text:String,  Image: UIImage, stack:dataStackAzure ){
        
        stackAzure = stack
        
        
        model = dataNews(title: title, text: text, blob: UIImageJPEGRepresentation(Image, 0.0)!, authors: (stackAzure.client.currentUser?.userId)!, coordenadas: (0,0), typeBlog: .img, urlFromBlob: UUID().uuidString, visible:false ,publicada:false)
        
      

        
        
        
    }
    
    func saveNews(){
        
        let blog = AzureStorage()
        
        
        // Guardo la Imagen
        
        blog.upLoadBlobWithSAS(data: model.blob, nameFile: model.urlData)
        
        // Guardo la noticia
        
        stackAzure.insertNew(title: model.title, text: model.text, latitude: 0.0, longitude: 0.0, urlPhoto: model.urlData)
        
        
    }
    
    
}
