//
//  Tools_ViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 22/03/23.
//

import UIKit

class Tools_ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout{
    let menu : [String] = ["Check for Update","Feedback","Share App","About Us","Other Apps"]
    
    @IBOutlet var main_view: UIView!
    @IBOutlet weak var show_menu: UIBarButtonItem!
    @IBOutlet var blur: UIVisualEffectView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var Setting_view: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var menuHeight: NSLayoutConstraint!
    @IBOutlet weak var historybuttons: UIBarButtonItem!
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25 )
    let numberOfItemsPerRow: CGFloat = 4
    let spacingBetweenCells: CGFloat = 10
    
    var tools : [Tools] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tools =   ToolsDAL.get_Tools()
        // Do any additional setup after loading the view.
        Setting_view.isHidden = true
        Setting_view.layer.cornerRadius = 10
        Setting_view.layer.zPosition = 1
        Setting_view.layer.borderWidth = 0.1
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.Setting_view.alpha = 0
        }, completion: nil)
        menuHeight.constant -= 130
        Setting_view.layer.masksToBounds = false
        Setting_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        Setting_view.layer.shadowRadius = 10
        Setting_view.layer.shadowOpacity = 0.2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0
        {
            return tools.count
        }
        else
        {
            return menu.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0
        {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Tools_TableViewCell
            cell.alpha = 0
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
                })
            let t : Tools = tools[indexPath.row]
            
            cell.Tool_image.image = UIImage(named: t.ToolName)
            cell.Tool_name.text = t.ToolName
            cell.layer.cornerRadius = 10
            cell.Tool_image.layer.cornerRadius = 20
            return cell
        }
        else
        {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Setting_TableViewCell
            cell.alpha = 0
            
            UIView.animate(
                withDuration: 1,
                delay: 0.15 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
                })
            menuHeight.constant += 43.5
            cell.textLabel?.text = menu[indexPath.row]
            cell.textLabel?.textAlignment =
                .center
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.tag == 0
        {
            let t : Tools = tools[indexPath.row]
            if (t.ToolName == "SIP")
            {
                let SIP : SIP_Display_ViewController = storyboard?.instantiateViewController(withIdentifier: "SIP_Display_ViewController") as! SIP_Display_ViewController
                self.navigationController?.pushViewController(SIP, animated: true)
            }
            
            if (t.ToolName == "SWP")
            {
                let SWP : SWP_DisplayViewController = storyboard?.instantiateViewController(withIdentifier: "SWP_DisplayViewController") as! SWP_DisplayViewController
                self.navigationController?.pushViewController(SWP, animated: true)
            }
            if (t.ToolName == "Lumpsum")
            {
                let Lumpsum : Lumpsum_DisplayViewController = storyboard?.instantiateViewController(withIdentifier: "Lumpsum_DisplayViewController") as! Lumpsum_DisplayViewController
                self.navigationController?.pushViewController(Lumpsum, animated: true)
            }
            if (t.ToolName == "SIP Planner")
            {
                let SIP_Planner : SIP_PlannerViewController = storyboard?.instantiateViewController(withIdentifier: "SIP_PlannerViewController") as! SIP_PlannerViewController
                self.navigationController?.pushViewController(SIP_Planner, animated: true)
            }
            
            tableview.isUserInteractionEnabled = true
            historybuttons.isEnabled = true
            tableView.deselectRow(at: indexPath, animated: true)
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.Setting_view.alpha = 0.0
                
            })
        }
        
        else
        {   if indexPath.row == 1
            {
           
            let Feedback : FeedBackViewController = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
            
    
//            navigationController?.present(navController, animated: true, completion: nil)
            self.navigationController?.pushViewController(Feedback, animated: true)
            
        }
            
            if indexPath.row == 2
            {
                let textToShare = "Download App to Calculate SIP, SWP, SIP planner and Lumpsum from App Store: "
                let objectsToShare = [textToShare]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                self.present(activityVC, animated: true, completion: nil)
            }
            if indexPath.row == 3
            {
                let Developer : DeveloperViewController = storyboard?.instantiateViewController(withIdentifier: "DeveloperViewController") as! DeveloperViewController
                self.navigationController?.pushViewController(Developer, animated: true)
            }
            if indexPath.row == 4
            {
                if #available(iOS 10.0, *) {
                    
                    let myUrl = "https://apps.apple.com/in/developer/g-sanghani/id772995906"
                    if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty{
                        UIApplication.shared.open(url,options: [:],completionHandler: nil)
                    }
                    guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
                        return
                    }
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                else
                {
                    //
                }
            }
            
        }
        
    }
    
    @IBAction func Show_History(_ sender: Any) {
        let Historys : History_ViewController = storyboard?.instantiateViewController(withIdentifier: "History_ViewController") as! History_ViewController
        self.navigationController?.pushViewController(Historys, animated: true)
    }
    
    @IBAction func Menu_Blur(_ sender: Any) {
        
        Setting_view.isHidden = false
        historybuttons.isEnabled = false
        tableview.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.Setting_view.alpha = 1.0
            
        })
    }
    
    
    @IBAction func pop_out(_ sender: UIButton) {
        
        historybuttons.isEnabled = true
        tableview.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.Setting_view.alpha = 0.0
            
        })
    }
    
}
