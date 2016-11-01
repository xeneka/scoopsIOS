//
//  AutorsViewModel.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 29/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreLocation

final class noteViewModel{
    
    var model:dataNews
    let stackAzure:dataStackAzure
    
    init(title:String, text:String,  Image: UIImage, stack:dataStackAzure, location:CLLocation ){
        
        stackAzure = stack
        
        
        
        
        model = dataNews(title: title, text: text, blob: UIImageJPEGRepresentation(Image, 0.0)!, authors: (stackAzure.client.currentUser?.userId)!, coordenadas: (location.coordinate.latitude,location.coordinate.longitude), typeBlog: .img, urlFromBlob: UUID().uuidString, visible:false ,publicada:false)
        
      

        
        
        
    }
    
    func saveNews(){
        
        let blog = AzureStorage()
        
        
        // Guardo la Imagen
        
        blog.upLoadBlobWithSAS(data: model.blob, nameFile: model.urlData)
        
        // Guardo la noticia
        
        stackAzure.insertNew(title: model.title, text: model.text, latitude: NSNumber(value: self.model.coordenadas.0), longitude: NSNumber(value: self.model.coordenadas.1), urlPhoto: model.urlData)
        
        
    }
    
    
}
