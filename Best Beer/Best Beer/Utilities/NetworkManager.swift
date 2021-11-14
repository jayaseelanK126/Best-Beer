//
//  NetworkManager.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import Foundation
import UIKit


class NetworkManager:NSObject
{
    class func GETMethodRequest(foodName: String,  success: @escaping (AnyObject?)->Void, Failure: @escaping (NSError)->Void)
    {
        let urlStr = foodName == "" ? AppConfig.baseURL : "\(AppConfig.baseURL)?food=\(foodName)"
        
        if ReachabilityManager.shared.isConnectedToNetwork() == false
        {
            ReachabilityManager.shared.noInternetConnectionAlert()
        }
        else if let url = URL(string: "\(urlStr)")
        {
            var request: URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 600.0)
            print("URL..\(url)")
            
            request.httpMethod = "GET"

            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                if(error == nil)
                {
                    do
                    {
                        if let httpResponse = response as? HTTPURLResponse
                        {
                            
                            let statusCode = httpResponse.statusCode
                            print(statusCode)
                            if (statusCode == 426)
                            {
                                
                            }
                            else if (statusCode == 503)
                            {
                                
                            }
                            else if (statusCode == 401)
                            {
                                //unauthorized user
                                
                                GenericMethod.showAlert("You are not authorized to access")
                            }
                            else if (statusCode == 200)
                            {
                                let JSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                                print("Response..", JSON)
                                
                                success(JSON as AnyObject?)     // Closure being called as a function
                                
                                // success(data)     // Closure being called as a function
                            }
                            else
                            {
                                GenericMethod.showAlert("Some error occured. Please try again later")
                            }
                        }
                        else
                        {
                            GenericMethod.showAlert("Some error occured. Please try again later")
                        }
                    }
                    catch let JSONError as NSError
                    {
                        Failure(JSONError as NSError)
                        print("JSON Error is \(JSONError)")
                        GenericMethod.showAlert("Some error occured. Please try again later")
                    }
                    
                }
                else
                {
                    Failure(error! as NSError)
                    print("Error is \(error!)")
                    GenericMethod.showAlert("Some error occured. Please try again later")
                    
                }
            })
            task.resume()
        }
    }
    
}

