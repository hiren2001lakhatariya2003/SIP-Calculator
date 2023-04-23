//
//  SettingViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 10/04/23.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var btnSelect: UIButton!
    
    let menu : [String] = ["Share App","About Us","FeedBack","Other Apps"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PopupView.layer.cornerRadius = 10
        PopupView.layer.masksToBounds = true
        PopupView.layer.borderColor = UIColor.gray.cgColor
        PopupView.layer.borderWidth = 0.2
        btnSelect.titleLabel?.text = "Cancel"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Setting_TableViewCell
        
        cell.Menu.text = menu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let Developer : DeveloperViewController = storyboard?.instantiateViewController(withIdentifier: "DeveloperViewController") as! DeveloperViewController

        if indexPath.row == 0
        {
            let share = UIActivityViewController(activityItems: ["Download SIP - Calculator App \niPhone:"], applicationActivities: nil)
            share.popoverPresentationController?.sourceView = self.view
            self.present(share, animated: true,completion: nil)
            
        }
        if indexPath.row == 1
        {
//            dismiss(animated: true, completion: nil)
            self.navigationController?.pushViewController(Developer, animated: true)
           
            
        }
        else if indexPath.row == 2
        {
//            self.navigationController?.pushViewController(Developer1, animated: true)
        }
        else
        {
//            self.navigationController?.pushViewController(Developer2, animated: true)
        }
        
    }
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
