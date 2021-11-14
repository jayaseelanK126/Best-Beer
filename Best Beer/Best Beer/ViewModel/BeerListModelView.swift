//
//  BeerListModelView.swift
//  Best Beer
//
//  Created by Pyramid on 13/11/21.
//

import Foundation
import RealmSwift

struct BeerListModelView
{
    func getBeerSuggestionList(_ foodName:String, beerResult: @escaping([BeerListModel]) -> Void )
    {
        let realm = try! Realm()
        
        
        let data = realm.objects(BeerListData_Tbl.self).filter("foodName = %@ ", foodName.trimmingCharacters(in: .whitespaces).lowercased())
        
        if !data.isEmpty
        {
            fetchBeerData(foodName.trimmingCharacters(in: .whitespaces).lowercased()) { result in
                beerResult(result)
            }
        }
        else
        {
            fetchBeerList(foodName, fetchResult: { result in
                
                let queue = OperationQueue()
                queue.maxConcurrentOperationCount = 3
                
                let op1 = BlockOperation(block: {
                    print("implementing op1")
                    
                    beerResult(result)
                    
                })
                
                let op2 = BlockOperation(block: {
                    print("implementing op2")
                    insertBeerData(result,foodName: foodName.trimmingCharacters(in: .whitespaces).lowercased(), success: {
                        fetchBeerData(foodName.trimmingCharacters(in: .whitespaces).lowercased()) { result in
                            
                            // beerResult(result)
                            
                        }
                    })
                })
                queue.addOperation(op1)
                queue.addOperation(op2)
                
                
            })
        }
        
    }
    
    func fetchBeerList(_ foodName:String, fetchResult: @escaping([BeerListModel]) -> Void)
    {
        
        NetworkManager.GETMethodRequest(foodName: foodName.trimmingCharacters(in: .whitespaces)) { data in
            if let safeData = data
            {
                let jsonObj = Parser.parseBeerList(apiResponse: safeData)
                
                
                if !jsonObj.isEmpty
                {
                    fetchResult(jsonObj)
                }
                else
                {
                    NotificationCenter.default.post(name: .didNoDataReceived, object: nil)
                }
            }
        } Failure: { error in
            GenericMethod.showAlert("Some error occured. Please try again later")
        }
        
    }
    
    //MARK: - Insert to local data base
    func insertBeerData(_ beerData: [BeerListModel], foodName:String, success: @escaping ()->Void)
    {
        let realm = try! Realm()
        
        try! realm.write {
            realm.cancelWrite()
        }
        
        print("Inserting.....")
        if !beerData.isEmpty
        {
            _ = beerData.map({ result in
                
                let beerObj = BeerListData_Tbl()
                
                try! realm.write {
                    
                    beerObj.MobilePrimaryId = beerObj.incrementMobilePrimaryId()
                    beerObj.id = result.id?.description ?? "0"
                    beerObj.beerName = result.name ?? ""
                    beerObj.tagline = result.tagline ?? ""
                    beerObj.image_url = result.image_url ?? ""
                    beerObj.abv = result.abv?.description ?? "0.0"
                    beerObj.beerImgData = GenericMethod.loadURLToData(urlStr: result.image_url ?? "https://i.postimg.cc/HxR2Vf6T/no-alcohol-sign-warning-isolated-260nw-323033006.png")
                    beerObj.foodName = foodName.trimmingCharacters(in: .whitespaces).lowercased()
                    realm.add(beerObj)
                }
            })
            success()
        }
        
    }
    
    //MARK: - Fetch data from local database
    func fetchBeerData(_ foodName:String, result:@escaping([BeerListModel]) -> Void)
    {
        let realm = try! Realm()
        let beerModel = realm.objects(BeerListData_Tbl.self).filter("foodName = %@ ", foodName)
        
        var beerModelArr: [BeerListModel] = []
        
        _ = Array(beerModel).map{ results in
            
            let beerListModelObj = BeerListModel()
            beerListModelObj.id = Int(results.id) ?? 0
            beerListModelObj.image_url = results.image_url
            beerListModelObj.abv = Double(results.abv) ?? 0.0
            beerListModelObj.tagline = results.tagline
            beerListModelObj.imgData = results.beerImgData
            beerListModelObj.name = results.beerName
            
            beerModelArr.append(beerListModelObj)
        }
        result(beerModelArr)
    }
}
