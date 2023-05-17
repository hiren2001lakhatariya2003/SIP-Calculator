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
    @objc optional func HttpWrapperfetchDataSuccessWithString(_ wrapper : HttpWrapper,dicsResponse : String,  statusCode : Int)
    @objc optional func HttpWrapperfetchDataFail(_ wrapper : HttpWrapper,error : String);
}

@objc class HttpWrapper: NSObject {

    weak var delegate:HttpWrapperDelegate! = nil

    func requestWithparamdictParamPOST(_ url : String ,dicsParams : [String: AnyObject])
    {
        if !self.checkInternetConnection()
        {
            return
        }
        NSLog("Request info url: %@ --: %@",url,dicsParams);
        let Header : HTTPHeaders = ["API_KEY":"1234"]
        AF.request(url, method: .post, parameters: dicsParams, encoding:
                    URLEncoding.httpBody, headers: Header)
        .responseString { response in

            switch response.result{
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

    func requestWithparamdictParamPOSTQuestionBackground(_ url : String ,dicsParams : [String: AnyObject])
    {
        if !self.checkInternetConnection()
        {
            return
        }
        NSLog("Request info url: %@ --: %@",url,dicsParams);

        //  let authorize = ""
        let Header : HTTPHeaders = ["API_KEY":"1234"]
        //        let manager = Alamofire.Manager.sharedInstance

        //        manager.session.configuration.timeoutIntervalForRequest = 300
        _ = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])
        AF.request(url, method: .post, parameters: dicsParams, encoding:
                    URLEncoding.httpBody, headers: Header)
        .responseString { response in

            switch response.result {

            case .failure(let error):
                print("Sucees But Error: \(error)")
            case .success(_): break

            }
        }
    }

    func requestWithparamdictParam<T: Decodable>(_ url : String, dicsParams: [String: AnyObject], completion: @escaping (Result<T, Error>) -> Void) {
        if !self.checkInternetConnection() {
            return
        }
        
        let parametetr : HTTPHeaders = ["Content-Type":"application/json"]

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: parametetr)
            .responseString { response in

                switch response.result{
                case .failure(let error):
                    print("Sucees But Error: \(error)")
                case .success(_):
                    break;
                }
            }
            .responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func requestWithparamdictParamGetDict<T: Decodable>(_ url: String, dicsParams: [String: AnyObject], responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        if !checkInternetConnection() {
            return
        }
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
        
        
            .responseString { response in
                switch response.result{
                case .failure(let error):
                    print("Sucees But Error: \(error)")
                case .success(_):
                    break;
                }
                
            }
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func requestWithparamdictParamPostMethod<T: Decodable>(_ url: String, dicsParams: Parameters, completion: @escaping (Result<T, Error>) -> Void) {
        if !self.checkInternetConnection() {
            return
        }
        NSLog("Request info url: %@ --: %@", url, dicsParams)
        
        let headers: HTTPHeaders = ["API_KEY": "1234"]
        
        URLSessionConfiguration.default.timeoutIntervalForRequest = 500
        
        AF.request(url, method: .post, parameters: dicsParams, encoding: URLEncoding.httpBody, headers: headers)
            .responseString { response in
                switch response.result {
                case .failure(let error):
                    print("Success But Error: \(error)")
                case .success(_):
                    break
                }
            }
            .responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func requestWithparamdictParamPostHeaderMethod<T: Decodable>(_ url: String, dicsParams: [String: Any], responseType: T.Type) {
        if !self.checkInternetConnection() {
            return
        }
        
        NSLog("Request info url: %@ --: %@", url, dicsParams);
        
        let authorize = ""
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authorize)"
        ]
        
        URLSessionConfiguration.default.timeoutIntervalForRequest = 300
        
        AF.request(url,
                   method: .post,
                   parameters: dicsParams,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .responseString { response in
                switch response.result {
                case .failure(let error):
                    print("Request failed with error: \(error)")
                case .success(_): break
                }
            }
            .responseDecodable(of: responseType) { response in
                print("Response JSON: \n \(response.result)")
                
                switch response.result {
                case .success(let value):
                    if let JSON = value as? T {
                        if let delegate = self.delegate {
                            delegate.HttpWrapperfetchDataSuccess?(self, dicsResponse: JSON as! NSDictionary)
                        }
                    } else {
                        print("Response not converted to JSON")
                    }
                case .failure(let error):
                    if let delegate = self.delegate {
                        delegate.HttpWrapperfetchDataFail?(self, error: error.localizedDescription)
                    }
                }
            }
    }

    
    func requestWithPostHeaderMethod<T: Decodable>(_ url: String, dicsParams: [String: Any], responseType: T.Type) {
        if !self.checkInternetConnection() {
            return
        }
        
        NSLog("Request info url: %@ --: %@", url, dicsParams);
        
        let authorize = ""
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authorize)"
        ]
        
        URLSessionConfiguration.default.timeoutIntervalForRequest = 300
        
        AF.request(url,
                   method: .post,
                   parameters: dicsParams,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .responseString { response in
                switch response.result {
                case .failure(let error):
                    print("Request failed with error: \(error)")
                case .success(_): break
                }
            }
            .responseDecodable(of: T.self) { response in
                print("Response JSON: \n \(response.result)")
                
                switch response.result {
                case .success(let value):
                    if let JSON = value as? [String: Any] {
                        if let delegate = self.delegate {
                            delegate.HttpWrapperfetchDataSuccess?(self, dicsResponse: JSON as NSDictionary)
                        }
                    } else if let JSON = value as? [AnyObject] {
                        if let delegate = self.delegate {
                            delegate.HttpWrapperfetchDataSuccessWithArray?(self, dicsResponse: JSON)
                        }
                    } else {
                        print("Response not converted to JSON")
                    }
                case .failure(let error):
                    if let delegate = self.delegate {
                        delegate.HttpWrapperfetchDataFail?(self, error: error.localizedDescription)
                    }
                }
            }
    }



    func checkInternetConnection() -> Bool
    {
        return true;
    }
    func isDictionary(_ object: Any) -> Bool {
        return ((object as? NSMutableDictionary) != nil) ? true : false
    }

    func isArray(_ object: Any) -> Bool {
        return ((object as? [AnyObject]) != nil) ? true : false
    }

}
