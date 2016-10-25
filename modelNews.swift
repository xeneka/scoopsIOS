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


struct  dataNews {
    var title:String
    var text:String
    var blob:Data
    var typeBlog:typeBlob
    var author:String
    var coordenadas:(Double, Double)
    var urlData:NSURL
}
