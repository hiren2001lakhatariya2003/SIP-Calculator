//
//  GlobalData.swift
//  DealAcceleration
//
//  Created by jayesh on 23/11/21.
//

import Foundation
import UIKit
import SystemConfiguration

extension UIImageView {
    
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
        
    }}


class GlobalData
{
    static var activityIndicator = UIActivityIndicatorView()
    static var messageFrame = UIView()
    static var Base_URL = "http://api.aswdc.in/Api/MST_AppVersions/PostAppFeedback/AppPostFeedback"
    
    static func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family     = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    static func displayActivityIndicator(view : UIView)
    {
        
        view.isUserInteractionEnabled = false
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 35, y: view.frame.midY - 35 - 35, width: 70, height: 70))
        messageFrame.layer.cornerRadius = 10
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        print(messageFrame.frame.midX)
        activityIndicator.frame = CGRect(x: 25 , y: 25, width: 20, height: 20)
        activityIndicator.startAnimating()
        messageFrame.addSubview(activityIndicator)
        view.addSubview(messageFrame)
        
    }
    
    static  func hideActivityIndicator(view : UIView)
    {
        activityIndicator.stopAnimating()
        messageFrame.isHidden = true
        view.isUserInteractionEnabled = true
    }
    
    static func showMessage(self1 : UIViewController,message : String)
    {
        let alert = UIAlertController(title: "API ", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self1.present(alert, animated: true, completion: nil)
    }
    
}
