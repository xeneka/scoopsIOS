//
//  modelNews.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 23/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation


enum typeBlob{
    case img, pdf
}

typealias coordenadasGPS = (Double , Double)


struct  dataNews {
    var title:String
    var text:String
    var blob:Data
    var typeBlog:typeBlob
    var author:String
    var coordenadas:coordenadasGPS
    var urlData:String
    var visible:Bool
    var idnew:String?
    
    init(title:String, text:String, blob:Data, authors:String, coordenadas:coordenadasGPS, typeBlog:typeBlob, urlFromBlob:String, visible:Bool) {
        
        self.title = title
        self.text = text
        self.blob = blob
        self.author = authors
        self.coordenadas = coordenadas
        self.urlData = urlFromBlob
        self.typeBlog = typeBlog
        self.visible = visible
        
        
        
    }
    
    init(title:String, text:String, blob:Data, authors:String, coordenadas:coordenadasGPS, typeBlog:typeBlob, urlFromBlob:String, visible:Bool, idnew:String) {
        
        self.title = title
        self.text = text
        self.blob = blob
        self.author = authors
        self.coordenadas = coordenadas
        self.urlData = urlFromBlob
        self.typeBlog = typeBlog
        self.visible = visible
        self.idnew = idnew
        
        
        
    }
    
    
    
}


