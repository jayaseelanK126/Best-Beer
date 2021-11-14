//
//  ReachabilityManager.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import UIKit
import Reachability

class ReachabilityManager: NSObject
{
    static let shared = ReachabilityManager()  // 2. Shared instance
    
    let reachability = try! Reachability()
    
    func startMonitoring()
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do
        {
            try reachability.startNotifier()
        }
        catch
        {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    func stopMonitoring()
    {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
    @objc func reachabilityChanged(notification: Notification)
    {
        unowned let reachability = notification.object as! Reachability
        switch reachability.connection
        {
        case .none:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        case .unavailable:
            debugPrint("Network became unreachable")
        }
    }
    
    func isConnectedToNetwork() -> Bool
    {
        let reachability = try! Reachability()
        var flag : Bool = false
        switch reachability.connection
        {
        case .none:
            flag = false
        case .wifi:
            flag = true
        case .cellular:
            flag = true
        case .unavailable:
            flag = false
        }
        
        return flag
    }
    
    func isCellularConnection() -> Bool
    {
        let reachability = try! Reachability()
        var flag : Bool = false
        
        switch reachability.connection
        {
        case .none:
            //debugPrint("Network became unreachable")
            flag = false
        case .wifi:
            //debugPrint("Network reachable through WiFi")
            flag = false
        case .cellular:
            //debugPrint("Network reachable through Cellular Data")
            flag = true
        case .unavailable:
            //debugPrint("None")
            flag = false
        }
        
        return flag
    }
    
    func noInternetConnectionAlert()
    {
        let alert = UIAlertController(title: "No Internet Connection", message: "Check your network settings and try again", preferredStyle: .alert)
        
        //Add Buttons
        let yesButton = UIAlertAction(title: "Settings", style: .default, handler: { action in
            //Handle your yes please button action here
            GenericMethod.openDeviceSettings()
        })
        
        let noButton = UIAlertAction(title: "Ok", style: .default, handler: { action in
            //Handle no, thanks button
        })
        
        alert.addAction(yesButton)
        alert.addAction(noButton)
        UIApplication.shared.topMostController().present(alert, animated: true)
        
    }
}
