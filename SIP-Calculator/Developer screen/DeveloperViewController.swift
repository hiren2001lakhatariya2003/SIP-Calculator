//
//  DeveloperViewController.swift
//  DLibrary
//
//  Created by MAC_04_31_24 on 12/02/16.
//  Copyright © 2016 diet. All rights reserved.
//

import UIKit
import MessageUI

class DeveloperViewController: UIViewController , MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var imgApp: UIImageView!
    @IBOutlet weak var lblAppTitle: UILabel!
    @IBOutlet weak var lblASWDCDes: UILabel!
    @IBOutlet weak var meetourteamview: UIView!
    @IBOutlet weak var shareview: UIView!
    @IBOutlet weak var contactusview: UIView!
    @IBOutlet weak var aboutview: UIView!
    @IBOutlet weak var mentorby: UILabel!
    @IBOutlet weak var contactus: UILabel!
    @IBOutlet weak var aboutaswdc: UILabel!
    @IBOutlet weak var imagedarshan: UIImageView!
    @IBOutlet weak var imageaswdc: UIImageView!
    @IBOutlet weak var developby: UILabel!
    @IBOutlet weak var meetourteam: UILabel!
    @IBOutlet weak var lblcontactemail: UILabel!
    @IBOutlet weak var lblContactNumber: UILabel!
    @IBOutlet weak var lblContactwebsite: UILabel!
    @IBOutlet weak var lblshare: UILabel!
    @IBOutlet weak var lblmore: UILabel!
    @IBOutlet weak var lblrate: UILabel!
    @IBOutlet weak var lbllike: UILabel!
    @IBOutlet weak var lblcheck: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meetourteamview.layer.borderColor  = UIColor(red: 203/255, green: 183/255, blue: 176/255, alpha: 1.0).cgColor
        aboutview.layer.borderColor  = UIColor(red: 203/255, green: 183/255, blue: 176/255, alpha: 1.0).cgColor
        contactusview.layer.borderColor  = UIColor(red: 203/255, green: 183/255, blue: 176/255, alpha: 1.0).cgColor
        shareview.layer.borderColor  = UIColor(red: 203/255, green: 183/255, blue: 176/255, alpha: 1.0).cgColor
        imgApp.layer.borderWidth = 0.2
        imgApp.layer.cornerRadius = 10
        imgApp.clipsToBounds = true
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
        
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
        let version = nsObject as! String
        lblAppTitle.text = "SIP Calculator(v\(version))"
        let htmlString  = "<html><body align=\"justify\"><font face=\"Arial\" color = \"#969696\">ASWDC is Application, Software and Website Development Center @ Darshan Engineering College run by Students and Staff of Computer Engineering Department.<br><br> Sole purpose of ASWDC is to bridge gap between university curriculum &amp; industry demands. Students learn cutting edge technologies, develop real world application &amp; experiences professional environment @ ASWDC under guidance of industry experts &amp; faculty members.</font></body></html>"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.firstLineHeadIndent = 0.001
        
        let attrStr = try! NSAttributedString(data: htmlString.data(using: String.Encoding.utf8)!, options: [.documentType: NSAttributedString.DocumentType.html] , documentAttributes: nil)
        meetourteam.layer.cornerRadius = 5
        meetourteam.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        meetourteamview.layer.cornerRadius = 5
        meetourteamview.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        aboutaswdc.layer.cornerRadius = 5
        aboutaswdc.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        aboutview.layer.cornerRadius = 5
        aboutview.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        contactus.layer.cornerRadius = 5
        contactus.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        contactusview.layer.cornerRadius = 5
        contactusview.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        shareview.layer.cornerRadius = 5
        lblASWDCDes.attributedText = attrStr
        lblContactwebsite.font = UIFont(name: "fontawesome", size: 13)
        lblContactwebsite.text = "\u{f0ac}"
        
        let formatter : DateFormatter =  DateFormatter()
        formatter.dateFormat = "yyyy"
        let yearString = formatter.string(from: Date())
        lblYear.text = "© \(yearString) Darshan Institute of Engineering & Technology"
        
    }
    
    @IBAction func actionContacEmail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["aswdc@darshan.ac.in"])
            present(mail, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: " There are no email accounts set up on the device.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //
    @IBAction func actionContactwebsite(sender: AnyObject) {
        //            UIApplication.shared.openURL(NSURL(string:"http://www.darshan.ac.in")! as URL)
        let myUrl = "http://www.darshan.ac.in"
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url,options: [:],completionHandler: nil)
        }
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func actionshare(_ sender: AnyObject) {
        let textToShare = "Download App to Calculate SIP, SWP, SIP planner and Lumpsum from App Store: "
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    @IBAction func actionRate(_ sender: AnyObject)
    {
        //        UIApplication.shared.openURL(URL(string:"http://tiny.cc/ispeed")!)
        let myUrl = "http://tiny.cc/ispeed"
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url,options: [:],completionHandler: nil)
        }
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func actionmore(_ sender: AnyObject) {
        
        let myUrl = "https://itunes.apple.com/in/developer/g-sanghani/id772995906"
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url,options: [:],completionHandler: nil)
        }
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func actionlike(_ sender: AnyObject) {
        
        let myUrl = "https://www.facebook.com/DarshanInstitute.Official"
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url,options: [:],completionHandler: nil)
        }
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func actionCheck(_ sender: AnyObject) {
        
        let myUrl = "http://tiny.cc/ispeed"
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url,options: [:],completionHandler: nil)
        }
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func actionContact(_ sender: Any) {
      
        let myUrl = "telprompt://+919727747317"
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty{
            UIApplication.shared.open(url,options: [:],completionHandler: nil)
        }
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
