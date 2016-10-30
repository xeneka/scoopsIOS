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
    
    init(title:String, Author:String, Image:UIImage, text:String ){
        
        model = dataNews(title: title, text: text, blob: UIImageJPEGRepresentation(Image, 0.0)!, authors: Author, coordenadas: (0,0), typeBlog: .img, urlFromBlob: UUID().uuidString )
        
    }
    
    func saveNews(){
        
        let blog = AzureStorage()
        let stackAzure = dataStackAzure()
        
        // Guardo la Imagen
        
        blog.upLoadBlobWithSAS(data: model.blob, nameFile: model.urlData)
        
        // Guardo la noticia
        
        stackAzure.insertNew(title: model.title, text: model.text, latitude: 0.0, longitude: 0.0, urlPhoto: model.urlData)
        
        
    }
    
    
}
