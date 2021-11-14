//
//  Parser.swift
//  Best Beer
//
//  Created by Pyramid on 13/11/21.
//

import Foundation
import Foundation
import ObjectMapper

class Parser: NSObject
{
    class func parseBeerList(apiResponse:AnyObject) -> [BeerListModel]
    {
        let responseObj = Mapper<BeerListModel>().mapArray(JSONArray: apiResponse as! [[String : Any]])
        
        return responseObj
    }
}
