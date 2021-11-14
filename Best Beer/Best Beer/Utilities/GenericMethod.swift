//
//  GenericMethod.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import Foundation
import UIKit

public class GenericMethod: NSObject
{
    //MARK: - Alert Methods
    
    class func showAlert(_ alertMessage: String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle:
            .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async
        {
            UIApplication.shared.topMostController().present(alert, animated: true, completion: nil)
        }
    }
    
    class func openDeviceSettings()
    {
        if let url = URL(string: UIApplication.openSettingsURLString)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    class func formatDateStr(dateStr: String, sourceDateFormat: String, destinationDateFormat: String) -> (dateStr : String, dateDate: Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceDateFormat
        let dateTime = dateFormatter.date(from: dateStr)
        
        if dateTime != nil
        {
            dateFormatter.dateFormat = destinationDateFormat
            let formatedDateTimeStr = dateFormatter.string(from: dateTime!)
            let formatedDateTime = dateFormatter.date(from: formatedDateTimeStr)
            return (formatedDateTimeStr,formatedDateTime!)
        }
        return ("",Date())
    }
    class func loadURLToData(urlStr: String) -> Data
    {
        if let url = URL(string: urlStr)
        {
            do
            {
                return try Data(contentsOf: url)
                
            }
            catch
            {
                print("\(error)")
            }
        }
        return Data()
    }
}


