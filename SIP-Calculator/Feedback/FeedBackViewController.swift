
//
//  AskLibrarianViewController.swift
//  DLibrary
//
//  Created by MAC_04_31_24 on 02/02/16.
//  Copyright © 2016 diet. All rights reserved.
//

import UIKit

import SystemConfiguration
@objc class BottomBorderTF: UITextField {
    
    var bottomBorder = UIView()
    override func awakeFromNib() {
        
        //MARK: Setup Bottom-Border
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        bottomBorder.backgroundColor = UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1.0)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        //Mark: Setup Anchors
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        
    }
}
@objc class FeedBackViewController: UIViewController , UITextFieldDelegate, HttpWrapperDelegate {
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtcontact: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtmessage: UITextView!
    @IBOutlet weak var vwForm: UIView!
    
    var activityIndicator = UIActivityIndicatorView()
    var messageFrame = UIView()
    let bottomline = CALayer()
    let bottomline1 = CALayer()
    let bottomline2 = CALayer()
    var feedbackRequest = HttpWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtmessage.layer.borderWidth = 1.0;
        self.txtmessage.layer.cornerRadius = 5;
        self.txtmessage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.txtmessage.layer.borderColor  = UIColor(red: 203/255, green: 183/255, blue: 176/255, alpha: 1.0).cgColor
        self.lblFeedback.layer.cornerRadius = 5;
        self.lblFeedback.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.vwForm.layer.cornerRadius = 5
        txtcontact.delegate = self
        
    }
    @IBAction func backbuttonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//
    
    @IBAction func clearAction(_ sender: Any) {
        txtname.text = ""
        txtmessage.text = ""
        txtEmail.text = ""
        txtcontact.text = ""
        txtname.becomeFirstResponder()
    }
    
    
    @IBAction func sendMail(_ sender: AnyObject) {
        
        var message = "Please enter "

        if txtname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            message = message + "Name "
        }
        else if(txtmessage.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            message = message +  "Message"
        }
        if (txtcontact.text!.trimmingCharacters(in: .whitespacesAndNewlines) != "")
        {
            if(!validatePhoneNumber(value: txtcontact.text!.trimmingCharacters(in: .whitespacesAndNewlines)))
            {
                message = message + "valid Mobile "
            }
        }
        if txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        {
            if(!isValidEmail(testStr: txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)))
            {
                message = message + "Valid Email "
            }
        }
        if(message != "Please enter ")
        {
            let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            serviceCall { (result: Result<String, Error>) in
                switch result {
                case .success(_): break
                    // handle successful response
                case .failure(_): break
                    // handle error
                }
            }
        }
    }
    func serviceCall<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        if self.isInternetAvailable() {
            displayActivityIndicator()
            let dic: [String: AnyObject] = [
                "AppName" : "SIP Calculator" as AnyObject,
                "VersionNo" : "1.0" as AnyObject,
                "Platform" : "IOS" as AnyObject ,
                "PersonName" : txtname.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
                "Mobile" : txtcontact.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
                "Email" : txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
                "Message" : txtmessage.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            ]
            let tempUrl = "http://api.aswdc.in/Api/MST_AppVersions/PostAppFeedback/AppPostFeedback"
            self.feedbackRequest = HttpWrapper()
            self.feedbackRequest.delegate = self
            self.feedbackRequest.requestWithparamdictParamPostMethod(tempUrl, dicsParams: dic) { result in
                completion(result)
            }
        } else {
            self.displaynoInternetconnection()
        }
    }

    @objc func HttpWrapperfetchDataSuccess(_ wrapper: HttpWrapper, dicsResponse: NSDictionary) {
        hideActivityIndicator()

        print(dicsResponse)
        if(String(describing: dicsResponse.value(forKey: "IsResult")!) == "1")
        {
            let alert = UIAlertController(title: "", message:"Your message has been sent successfully", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))

            self.present(alert, animated: true, completion: nil)

        }
        else
        {
            let alert = UIAlertController(title: "", message:"Error occurred please try again late", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

            }))

            self.present(alert, animated: true, completion: nil)


        }



    }

    @objc func HttpWrapperfetchDataSuccessWithArray(_ wrapper: HttpWrapper, dicsResponse: [AnyObject]) {

    }

    private func HttpWrapperfetchDataFail(_ wrapper: HttpWrapper, error: NSError) {
        hideActivityIndicator()

         GlobalData.showMessage(self1: self, message: "Error occurred please try again later")

    }

    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func displaynoInternetconnection()
    {
        let alert = UIAlertController(title: "", message:"Please check your internet connection.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

        }))

        self.present(alert, animated: true, completion: nil)
    }
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

    func validatePhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }

    func displayActivityIndicator()
    {
        self.view.isUserInteractionEnabled = false
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 70, y: view.frame.midY - 70 - 70 , width: 140, height: 140))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        print(messageFrame.frame.midX)
        activityIndicator.frame = CGRect(x: 60, y: 30, width: 20, height: 20)
        activityIndicator.startAnimating()
        messageFrame.addSubview(activityIndicator)
        let strLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 140, height: 50))
        strLabel.textAlignment = NSTextAlignment.center
        strLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        strLabel.text = "Loading..."
        strLabel.textColor = UIColor.white
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)

    }
    func hideActivityIndicator()
    {
        activityIndicator.stopAnimating()
        messageFrame.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    func isInternetAvailable() -> Bool
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
}

