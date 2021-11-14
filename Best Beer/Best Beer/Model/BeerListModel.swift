//
//  BeerListModel.swift
//  Best Beer
//
//  Created by Pyramid on 13/11/21.
//

import Foundation
import ObjectMapper

class BeerListModel:Mappable
{
    var id :Int?
    var image_url: String?
    var abv: Double?
    var name:String?
    var tagline:String?
    var imgData: Data?
    
    required init?(map: Map)
    {
        
    }
    
    init()
    {
        
    }
    
    func mapping(map: Map)
    {
        id         <- map["id"]
        image_url         <- map["image_url"]
        abv         <- map["abv"]
        name         <- map["name"]
        tagline         <- map["tagline"]
    }
    
}
