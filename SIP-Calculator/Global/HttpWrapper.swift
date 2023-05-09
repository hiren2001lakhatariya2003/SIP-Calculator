////
////  HttpWrapper.swift
////  OvationTube
////
////  Created by MitulM on 01/01/16.
////  Copyright © 2016 MitulM. All rights reserved.
////
//
//import UIKit
//import Alamofire
//
//@objc protocol HttpWrapperDelegate{
//    @objc optional func HttpWrapperfetchDataSuccess(_ wrapper : HttpWrapper,dicsResponse : NSDictionary)
//    @objc optional func HttpWrapperfetchDataSuccessWithArray(_ wrapper : HttpWrapper,dicsResponse : [AnyObject])
//    @objc optional func HttpWrapperfetchDataSuccessWithString(_ wrapper : HttpWrapper,dicsResponse : String,  statusCode : Int)
//    @objc optional func HttpWrapperfetchDataFail(_ wrapper : HttpWrapper,error : String);
//}
//
//@objc class HttpWrapper: NSObject {
//
//    weak var delegate:HttpWrapperDelegate! = nil
//
//    func requestWithparamdictParamPOST(_ url : String ,dicsParams : [String: AnyObject])
//    {
//        if !self.checkInternetConnection()
//        {
//            return
//        }
//        NSLog("Request info url: %@ --: %@",url,dicsParams);
//        let Header : HTTPHeaders = ["API_KEY":"1234"]
//        AF.request(url, method: .post, parameters: dicsParams, encoding:
//                    URLEncoding.httpBody, headers: Header)
//        .responseString { response in
//
//            switch response.result{
//            case .success(let value):
//                if (self.delegate != nil){
//                    self.delegate.HttpWrapperfetchDataSuccessWithString?(self, dicsResponse: value, statusCode: response.response?.statusCode ?? 0 )
//                }
//            case .failure(let error):
//
//                print("Sucees But Error: \(error)")
//
//                self.delegate.HttpWrapperfetchDataFail?(self, error: "\(error)")
//
//
//            }
//        }
//    }
//
//    func requestWithparamdictParamPOSTQuestionBackground(_ url : String ,dicsParams : [String: AnyObject])
//    {
//        if !self.checkInternetConnection()
//        {
//            return
//        }
//        NSLog("Request info url: %@ --: %@",url,dicsParams);
//
//        //  let authorize = ""
//        let Header : HTTPHeaders = ["API_KEY":"1234"]
//        //        let manager = Alamofire.Manager.sharedInstance
//
//        //        manager.session.configuration.timeoutIntervalForRequest = 300
//        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])
//        AF.request(url, method: .post, parameters: dicsParams, encoding:
//                    URLEncoding.httpBody, headers: Header)
//        .responseString { response in
//
//            switch response.result {
//
//            case .failure(let error):
//                print("Sucees But Error: \(error)")
//            case .success(_): break
//
//            }
//        }
//    }
//
//
//    func requestWithparamdictParam(_ url : String ,dicsParams : [String: AnyObject])
//    {
//        if !self.checkInternetConnection()
//        {
//            return
//        }
//        NSLog("Request info url: %@ --: %@",url,dicsParams);
//
//        //  let authorize = ""
//        let parametetr : HTTPHeaders = ["Content-Type":"application/json"]
//        //        let manager = Alamofire.Manager.sharedInstance
//
//        //        manager.session.configuration.timeoutIntervalForRequest = 300
//
//        AF.request(url, method: .get, parameters: nil, encoding:
//                    URLEncoding.httpBody, headers: parametetr)
//        .responseString { response in
//
//            switch response.result{
//            case .failure(let error):
//                print("Sucees But Error: \(error)")
//            case .success(_):
//                break;
//            }
//        }
//        .responseDecodable { response in
//            print("Response JSON: \n \(String(describing: response.result))")
//            //                AppHelper.hideLoadingSpinner()
//            switch response.result{
//            case .success(let value):
//                if let JSON : Any = value as? String{
//                    //                        var mydict = NSMutableDictionary()
//                    //                        mydict = JSON as! NSMutableDictionary
//
//                    if(self.isDictionary(JSON) == false && self.isArray(JSON) == true)
//                    {
//                        if (self.delegate != nil){
//                            self.delegate.HttpWrapperfetchDataSuccessWithArray?(self, dicsResponse: JSON as! [AnyObject])
//                        }
//                    }
//                    else{
//
//                        if (self.delegate != nil){
//                            self.delegate.HttpWrapperfetchDataFail!(self, error: NSError() as! String);
//                        }
//
//                    }
//                }
//                else
//                {
//                    print("response not converted to JSON")
//                }
//
//
//            case .failure(let error):
//                if (self.delegate != nil){
//                    self.delegate.HttpWrapperfetchDataFail!(self, error: (error as NSError) as! String);
//                }
//            }
//
//        }
//        //            .responseString { response in
//        //                NSLog("upload.response : response : %@", response.result.value!)
//        //            }
//    }
//
//
//
//    func requestWithparamdictParamGetDict(_ url : String ,dicsParams : [String: AnyObject])
//    {
//        if !self.checkInternetConnection()
//        {
//            return
//        }
//        NSLog("Request info url: %@ --: %@",url,dicsParams);
//
//
//        let parametetr : HTTPHeaders = ["Content-Type":"application/json"]
//
//        AF.request(url, method: .get, parameters: nil, encoding:
//                    URLEncoding.httpBody, headers: parametetr)
//        .responseString { response in
//            switch response.result{
//            case .failure(let error):
//                print("Sucees But Error: \(error)")
//            case .success(_):
//                break;
//            }
//
//
//        }
//        .responseDecodable { response in
//            print("Response JSON: \n \(String(describing: response.result))")
//            //                AppHelper.hideLoadingSpinner()
//            switch response.result{
//            case .success(let value):
//                if let JSON : Any = value as? String {
//                    var mydict = NSDictionary()
//                    mydict = JSON as! NSDictionary
//
//                    if (self.delegate != nil){
//                        self.delegate.HttpWrapperfetchDataSuccess?(self, dicsResponse: mydict)
//                    }
//                }
//                else
//                {
//                    print("response not converted to JSON")
//                }
//
//
//            case .failure(_):
//                if (self.delegate != nil){
//                    self.delegate.HttpWrapperfetchDataFail!(self, error: NSError() as! String);
//                }
//            }
//
//        }
//    }
//
//    func requestWithparamdictParamPostMethod(_ url : String ,dicsParams : Parameters)
//    {
//        if !self.checkInternetConnection()
//        {
//            return
//        }
//        NSLog("Request info url: %@ --: %@",url,dicsParams);
//
//        let headers : HTTPHeaders = ["API_KEY": "1234"]
//
//        URLSessionConfiguration.default.timeoutIntervalForRequest = 500
//
//        //        let manager = Alamofire.Manager.sharedInstance
//        //        Alamofire.Manager.sharedInstance.session.configuration.timeoutIntervalForRequest = 300
//
//
//
//        AF.request(url, method: .post, parameters: dicsParams, encoding:
//                    URLEncoding.httpBody,headers: headers)
//        .responseString { response in
//
//            switch response.result{
//            case .failure(let error):
//                print("Sucees But Error: \(error)")
//            case .success(_):
//                break
//            }
//
//
//        }
//        .responseDecodable { response in
//            //                AppHelper.hideLoadingSpinner()
//            print("Response JSON: \n \(response.result)")
//            switch response.result{
//            case .success(let value):
//                if let JSON : Any = value as? String
//                {
//                    var mydict = NSDictionary()
//                    mydict = JSON as! NSDictionary
//
//                    if (self.delegate != nil){
//                        self.delegate.HttpWrapperfetchDataSuccess?(self, dicsResponse: mydict as NSDictionary)
//                    }
//                }
//                else
//                {
//                    //                        AppHelper.hideLoadingSpinner()
//                    print("response not converted to JSON")
//                    //                        AppHelper.showAlertWithTitle("", description1: "Please try again.")
//                }
//
//            case .failure(let error):
//                if (self.delegate != nil){
//                    self.delegate.HttpWrapperfetchDataFail!(self, error: (error as NSError) as! String);
//                }
//            }
//        }
//        //            .responseString { response in
//        //                NSLog("upload.response : response : %@", response.result.value!)
//        //            }
//    }
//
//    func requestWithparamdictParamPostHeaderMethod(_ url : String ,dicsParams : [String : Any])
//    {
//        if !self.checkInternetConnection()
//        {
//            return
//        }
//        NSLog("Request info url: %@ --: %@",url,dicsParams);
//
//
//        let authorize = ""
//        let parametetr = ["Content-Type":"application/json","Authorization":"Bearer \(authorize)"]
//
//        let headers: HTTPHeaders = [
//            "Content-Type":"application/json",
//            "Authorization":"Bearer \(authorize)"
//        ]
//
//
//
//
//
//        URLSessionConfiguration.default.timeoutIntervalForRequest = 300
//
//        AF.request(url, method: .post, parameters: dicsParams, encoding: JSONEncoding.default, headers: headers)
//            .responseString { response in
//
//                switch response.result{
//                case .failure(let error):
//                    print("Sucees But Error: \(error)")
//                case .success(_): break
//                }
//
//            }
//            .responseDecodable { response in
//                //                AppHelper.hideLoadingSpinner()
//                print("Response JSON: \n \(response.result)")
//
//
//                switch response.result{
//                case .success(let value):
//
//                    if let JSON : Any = value as? String
//                    {
//                        var mydict = NSDictionary()
//                        mydict = JSON as! NSDictionary
//
//                        if (self.delegate != nil){
//                            self.delegate.HttpWrapperfetchDataSuccess?(self, dicsResponse: mydict as NSDictionary)
//                        }
//                    }
//                    else
//                    {
//                        print("response not converted to JSON")
//
//                    }
//
//
//                case .failure(let error):
//                    if (self.delegate != nil){
//                        self.delegate.HttpWrapperfetchDataFail!(self, error: (error as NSError) as! String);
//                    }
//                }
//            }
//    }
//
//    func requestWithPostHeaderMethod(_ url : String ,dicsParams : [String : Any])
//    {
//        if !self.checkInternetConnection()
//        {
//            return
//        }
//        NSLog("Request info url: %@ --: %@",url,dicsParams);
//
//
//        let authorize = ""
//        let parametetr : HTTPHeaders = ["Content-Type":"application/json","Authorization":"Bearer \(authorize)"]
//
//        let headers: HTTPHeaders = [
//            "Content-Type":"application/json",
//            "Authorization":"Bearer \(authorize)"
//        ]
//
//        URLSessionConfiguration.default.timeoutIntervalForRequest = 300
//
//
//        AF.request(url, method: .post, parameters: dicsParams, encoding: JSONEncoding.default, headers: parametetr)
//            .responseString { response in
//                switch response.result{
//                case .failure(let error):
//                    print("Sucees But Error: \(error)")
//                case .success(_):
//                    break
//                }
//            }
//            .responseDecodable{ response in
//                //                AppHelper.hideLoadingSpinner()
//                print("Response JSON: \n \(response.result)")
//                //            if((response.result.error) == nil)
//                //            {
//                switch response.result{
//                case .success(let value):
//
//
//                    if let JSON : Any = value as? String
//                    {
//                        var mydict = NSDictionary()
//                        mydict = JSON as! NSDictionary
//
//                        if (self.delegate != nil){
//                            self.delegate.HttpWrapperfetchDataSuccess?(self, dicsResponse: mydict as NSDictionary)
//                        }vvv
//                    }
//                    else if let JSON : Any = value as? String
//                    {
//                        var mydict = [AnyObject]()
//                        mydict = JSON as! [AnyObject]
//
//                        if (self.delegate != nil){
//                            self.delegate.HttpWrapperfetchDataSuccessWithArray!(self, dicsResponse: mydict as [AnyObject])
//                        }
//                    }
//                    else
//                    {
//                        //                        AppHelper.hideLoadingSpinner()
//                        print("response not converted to JSON")
//                        //                        AppHelper.showAlertWithTitle("", description1: "Please try again.")
//                    }
//                case .failure(let error):
//                    if (self.delegate != nil){
//                        self.delegate.HttpWrapperfetchDataFail!(self, error: (error as NSError) as! String);
//                    }
//                }
//
//            }
//    }
//
//
//    func checkInternetConnection() -> Bool
//    {
//        return true;
//    }
//    func isDictionary(_ object: Any) -> Bool {
//        return ((object as? NSMutableDictionary) != nil) ? true : false
//    }
//
//    func isArray(_ object: Any) -> Bool {
//        return ((object as? [AnyObject]) != nil) ? true : false
//    }
//
//}
