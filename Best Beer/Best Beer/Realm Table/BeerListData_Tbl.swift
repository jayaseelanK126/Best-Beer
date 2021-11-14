//
//  FoodNameTbl.swift
//  Best Beer
//
//  Created by Pyramid on 13/11/21.
//

import Foundation
import RealmSwift

//MATK:- Realm table
class BeerListData_Tbl: Object
{
    @objc dynamic var MobilePrimaryId: Int = 1
    @objc dynamic var id: String = ""
    @objc dynamic var image_url: String = ""
    @objc dynamic var beerName: String = ""
    @objc dynamic var abv: String = ""
    @objc dynamic var tagline: String = ""
    @objc dynamic var beerImgData: Data?
    @objc dynamic var foodName: String = ""
    
    override class func primaryKey() -> String?
    {
        return "MobilePrimaryId"
    }
    
    func incrementMobilePrimaryId() -> Int
    {
        let realm = try! Realm()
        return (realm.objects(BeerListData_Tbl.self).max(ofProperty: "MobilePrimaryId") as Int? ?? 0) + 1
    }
}
