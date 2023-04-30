//
//  HttpWrapper.swift
//  OvationTube
//
//  Created by MitulM on 01/01/16.
//  Copyright © 2016 MitulM. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol HttpWrapperDelegate{
    @objc optional func HttpWrapperfetchDataSuccess(_ wrapper : HttpWrapper,dicsResponse : NSDictionary)
    
    @objc optional func HttpWrapperfetchDataSuccessWithArray(_ wrapper : HttpWrapper,dicsResponse : [AnyObject])
    
    @objc optional func HttpWrapperfetchDataSuccessWithString(_ wrapper : HttpWrapper,dicsResponse : String , statusCode : Int)
    
    @objc optional func HttpWrapperfetchDataFail(_ wrapper : HttpWrapper,error : String);
}

class HttpWrapper: NSObject {
    
    weak var delegate:HttpWrapperDelegate! = nil
    
    func requestget(_ url : String ,dicsParams : [String: AnyObject])
    {
        if !GlobalData.isInternetAvailable()
        {
            return
        }
        NSLog("Request info url: %@ --: %@",url,dicsParams);
        let parametetr :HTTPHeaders = ["Content-Type":"application/json"]
        
        AF.request(url, method: .post, parameters: nil, encoding:
                    URLEncoding.httpBody, headers: parametetr)
        
        .responseString { response in
            
            switch response.result {
                
            case .success(let value):
                if (self.delegate != nil){
                
                    self.delegate.HttpWrapperfetchDataSuccessWithString?(self, dicsResponse: value, statusCode: response.response?.statusCode ?? 0 )
                }
            case .failure(let error):
                print("Sucees But Error: \(error)")
                
                self.delegate.HttpWrapperfetchDataFail?(self, error: "\(error)")
            }
            
        }
    }
    
    
    
}
