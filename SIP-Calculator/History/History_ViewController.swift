//
//  History_ViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 18/03/23.
//

import UIKit
import Charts
import Foundation


class History_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var pie_chart = PieChartView()
    var history : [History] = []
    var tools : [Tools] = []
    var stringFormate : String = String()
    var tableviewcell = History_TableViewCell()
    let heightforcell = 50
    @IBOutlet weak var delete_all_btn: UIBarButtonItem!
    
    @IBOutlet weak var history_Table: UITableView!
    @IBOutlet weak var Display_Empty_trash: UIView!
    @IBOutlet weak var GIF: UIImageView!
    @IBOutlet var Main_View_Colour: UIView!
    
    
    
    func change(num: Double) -> String
    {
        let formatter = NumberFormatter()              // Cache this, NumberFormatter creation is expensive.
        formatter.locale = Locale(identifier: "en_IN") // Here indian locale with english language is used
        formatter.numberStyle = .decimal               // Change to `.currency` if needed
        
        let asd = formatter.string(from: NSNumber(value: round(num * 1) / 1)) ?? ""
        return asd
        
    }
    
    func formate(num : Double) -> String
    {
        var number  = num
        
        if (number < 1000)
        {
            stringFormate = String(Int(number))
        }
        if ( number >= 1000.00 && number < 100000.00)
        {
            number = number / 1000.00
            number = round(number * 100) / 100
            stringFormate = String(number) + " K"
        }
        else if( number >= 100000.00 && number < 10000000.00)
        {
            number = number / 100000.00
            number = round(number * 100) / 100
            stringFormate =  String(number) + " L"
        }
        else if( number >= 10000000.00)
        {
            number = number / 10000000.00
            number = round(number * 100) / 100
            stringFormate = String(number) + " Cr"
        }
        return stringFormate
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Main_View_Colour.backgroundColor = UIColor(red: (216/255), green: (247/255), blue: (255/255), alpha: 1)
        
       
    }
    
    func loadGIF()
    {
        GIF.loadGif(name: "trash-1991_512")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadHistory()
        
        if(history.count > 0)
        {
            Display_Empty_trash.isHidden = true
            history_Table.isHidden = false
            GIF.stopAnimating()
            if #available(iOS 16.0, *) {
                self.delete_all_btn.isHidden = false
            } else {
                // Fallback on earlier versions
            }
            
        }
        else
        {
            Display_Empty_trash.isHidden = false
            history_Table.isHidden = true
            loadGIF()
            if #available(iOS 16.0, *) {
                self.delete_all_btn.isHidden = true
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        GIF.stopAnimating()
    }
    
    func loadHistory()
    {
        history =  HistoryDAL.get_History()
        history_Table.reloadData();
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "History" , for: indexPath) as! History_TableViewCell;
        
        cell.Lumpsum_View.layer.masksToBounds = false
        cell.Lumpsum_View.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.Lumpsum_View.layer.shadowRadius = 3
        cell.Lumpsum_View.layer.shadowOpacity = 0.2
        cell.SWP_View.layer.masksToBounds = false
        cell.SWP_View.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.SWP_View.layer.shadowRadius = 3
        cell.SWP_View.layer.shadowOpacity = 0.2
        cell.SIP_View.layer.masksToBounds = false
        cell.SIP_View.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.SIP_View.layer.shadowRadius = 3
        cell.SIP_View.layer.shadowOpacity = 0.2
        cell.SIPP_View.layer.masksToBounds = false
        cell.SIPP_View.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.SIPP_View.layer.shadowRadius = 3
        cell.SIPP_View.layer.shadowOpacity = 0.2
        let h: History = history[indexPath.row];
        cell.SIP_View.isHidden = true
        cell.Lumpsum_View.isHidden = true
        cell.SWP_View.isHidden = true
        cell.SIPP_View.isHidden = true
        
        if(h.toolId == 1)
        {
            cell.SIP_View.isHidden = false
            cell.Expected_Return.text = String(h.SIP_RateOfReturn) + " %"
            cell.Tenure.text = String(Int(h.SIP_Year)) + " Years"
            cell.Monthly_Amount.text = change(num: h.SIP_MonthlyAmount)
            cell.Total_Value.text = formate(num: h.SIP_TotalValue)
            cell.Invested_Amount.text = formate(num:  h.SIP_TotalInvestAmount)
            cell.SIP_Date.text = h.SIP_Date
            cell.delete.tag = indexPath.row
            cell.delete.addTarget(self, action: #selector(Delete_Individual(sender:)), for: .touchUpInside)
//            cell.delete_SIP_multiple.addTarget(self, action: #selector(Delete_multiple(sender:)), for: .touchUpInside)
//    
        }
        else if(h.toolId == 3)
        {
            cell.Lumpsum_View.isHidden = false
            cell.LInvested_Amount.text = change(num: h.Lumpsum_InvestedAmount)
            cell.LExpected_Return.text = String(h.Lumpsum_RateOfReturn)  + " %"
            cell.LTenure.text = String(Int(h.Lumpsum_Year))  + " Years"
            cell.LTotal_Value.text = formate(num: h.Lumpsum_TotalValue)
            cell.LTotal_Investment.text = formate(num: h.Lumpsum_TotalInvestment)
            cell.Lumpsum_Date.text = h.Lumpsum_Date
            cell.Lumpsum_delete.tag = indexPath.row
            cell.Lumpsum_delete.addTarget(self, action: #selector(Delete_Individual(sender:)), for: .touchUpInside)
        }
        else if(h.toolId == 2)
        {
            cell.SWP_View.isHidden = false
            
            cell.Total_Investment.text = change(num: h.SWP_TotalInvestment)
            cell.Withdrawal_Amount.text = change(num: h.SWP_WithdrawalAmount)
            cell.SWP_Expected_return.text = String(h.SWP_RateOfReturn) + " %"
            cell.SWP_Tenure.text = String(Int(h.SWP_Year)) + " Years"
            cell.Total_Withdrawal.text = formate(num: h.SWP_TotalWithdrawals)
            cell.Final_Balance.text = formate(num: h.SWP_FinalBalance)
            cell.SWP_Date.text = h.SWP_Date
            cell.SWP_Delete.tag = indexPath.row
            cell.SWP_Delete.addTarget(self, action: #selector(Delete_Individual(sender:)), for: .touchUpInside)
            
            
        }
        else if(h.toolId == 4)
        {
            cell.SIPP_View.isHidden = false
            cell.SIPP_Expected_Amount.text = change(num: h.SIPP_ExpectedAmount)
            cell.SIPP_Rate_Of_Return.text = String(h.SIPP_RateOfReturn) + " %"
            cell.SIPP_Tenure.text = String(Int(h.SIPP_Year)) + " Years"
            cell.SIPP_Invested_Amount.text = formate(num: h.SIPP_InvestedAmount)
            cell.SIPP_Monthly_Amount.text = formate(num: h.SIPP_MonthlyAmount)
            cell.SIP_PLANNER_DATE.text = h.SIPP_Date
            cell.SIPP_Delete.tag = indexPath.row
            cell.SIPP_Inflaction.text = String(h.SIPP_Inflaction) + " %"
            cell.SIPP_Delete.addTarget(self, action: #selector(Delete_Individual(sender:)), for: .touchUpInside)
        }
        return cell
        
    }
    
    
    
    
    @IBAction func Delete_All(_ sender: Any) {
        
        let mainAlert = UIAlertController(title: "Delete History", message: "Select Deleting Option", preferredStyle: .actionSheet)
        mainAlert.addAction(UIAlertAction(title: "Delete All", style: .default, handler: { (_ action) in
            let alert = UIAlertController(title: "Clear \"History\"?", message:"Clear all the history.", preferredStyle: .alert)
            
            let Cancle = UIAlertAction(title: "Cancel" , style: .default) { (_ action) in
                //code here…
            }
            alert.addAction(Cancle)
            self.present(alert, animated: true, completion: nil)
            
            let Delete = UIAlertAction(title: "Clear" , style: .default) { (_ action) in
                let status = HistoryDAL.delete_all()
                if status
                {
                    self.loadHistory()
                    self.Display_Empty_trash.isHidden = false
                    self.history_Table.isHidden = true
                    self.loadHistory()
                    self.loadGIF()
                    if #available(iOS 16.0, *) {
                        self.delete_all_btn.isHidden = true
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    self.Main_View_Colour.backgroundColor = UIColor(red: (216/255), green: (247/255), blue: (255/255), alpha: 1)
                    
                }
            }
            Delete.setValue(UIColor.red, forKey: "titleTextColor")
            alert.addAction(Delete)
            
        }))
        mainAlert.addAction(UIAlertAction(title: "Delete Individual", style: .default, handler: { (_ action) in
            self.history_Table.allowsSelectionDuringEditing = true
        }))
        mainAlert.addAction(UIAlertAction(title: "Cencel", style: .cancel))
        self.present(mainAlert, animated: true)
        
    }
    
    @objc func Delete_Individual(sender: UIButton) {
        
        let Lumpsum_delete = sender.tag
        let h: History = history[Lumpsum_delete];
        let alert = UIAlertController(title: "Delete record?", message:"Delete \(h.toolName)'s record", preferredStyle: .alert)
        
        let Cancle = UIAlertAction(title: "Cancle" , style: .default) { (_ action) in
            //code here…
        }
        let Delete = UIAlertAction(title: "Delete" , style: .default) { (_ action) in
           
            let status = HistoryDAL.delete_Cal(h: h)
            if status
            {
                self.loadHistory()
                if (self.history.count <= 0)
                {
                    if #available(iOS 16.0, *) {
                        self.delete_all_btn.isHidden = true
                    } else {
                        // Fallback on earlier versions
                    }
                    self.Display_Empty_trash.isHidden = false
                    self.loadGIF()
                    self.history_Table.isHidden = true
                    self.Main_View_Colour.backgroundColor = UIColor(red: (216/255), green:(247/255), blue: (255/255), alpha: 1)
                }
                else
                {
                    if #available(iOS 16.0, *) {
                        self.delete_all_btn.isHidden = false
                    } else {
                        // Fallback on earlier versions
                    }
                    self.Display_Empty_trash.isHidden = true
                    self.history_Table.isHidden = false
                }
            }
            
        }
        Delete.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(Cancle)
        alert.addAction(Delete)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @objc func Delete_multiple(sender: UIButton) {}
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let h : History = history[indexPath.row];
        
        if (h.toolId == 1)
        {
            let dvc : Details_ViewController = storyboard?.instantiateViewController(withIdentifier: "Details_ViewController") as! Details_ViewController
            
            dvc.MonthlyAmount = h.SIP_MonthlyAmount
            dvc.RateOfReturn = h.SIP_RateOfReturn
            dvc.Tenure = h.SIP_Year
            dvc.TotalInvestAmount = h.SIP_TotalInvestAmount
            dvc.ExpectedReturn = h.SIP_ExpectedReturn
            dvc.TotalValue = h.SIP_TotalValue
            dvc.fromScreen = "SIP"
            self.navigationController?.pushViewController(dvc, animated: true)
            
        }
        else if(h.toolId == 2)
        {
            let SWPdvc : SWP_DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "SWP_DetailsViewController") as! SWP_DetailsViewController
            
            SWPdvc.totalInvestedAmount = h.SWP_TotalInvestment
            SWPdvc.withdrawalAmount = h.SWP_WithdrawalAmount
            SWPdvc.RateOfReturn = h.SWP_RateOfReturn
            SWPdvc.Year = h.SWP_Year
            SWPdvc.FinalBalance = h.SWP_FinalBalance
            SWPdvc.EstimatedReturn = h.SWP_ExpectedReturn
            SWPdvc.totalWithdrawal = h.SWP_TotalWithdrawals
            SWPdvc.cell_count = (Int32(h.SWP_Year) * 12);
            SWPdvc.Count = h.SWP_Count
            self.navigationController?.pushViewController(SWPdvc, animated: true)
        }
        
        if(h.toolId == 3)
        {
            let dvc : Details_ViewController = storyboard?.instantiateViewController(withIdentifier: "Details_ViewController") as! Details_ViewController
            
            dvc.TotalAmount = h.Lumpsum_TotalInvestment
            dvc.RateOfReturn = h.Lumpsum_RateOfReturn
            dvc.Tenure = h.Lumpsum_Year
            dvc.TotalInvestAmount = h.Lumpsum_InvestedAmount
            dvc.ExpectedReturn = h.Lumpsum_ExpectedReturn
            dvc.TotalValue = h.Lumpsum_TotalValue
            dvc.fromScreen = "Lumpsum"
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        if(h.toolId == 4)
        {
            let dvc : Details_ViewController = storyboard?.instantiateViewController(withIdentifier: "Details_ViewController") as! Details_ViewController
            
            dvc.ExpectedAmount = h.SIPP_ExpectedAmount
            dvc.RateOfReturn = h.SIPP_RateOfReturn
            dvc.Tenure = h.SIPP_Year
            dvc.MonthlyAmount = h.SIPP_MonthlyAmount
            dvc.ExpectedReturn = h.SIPP_EstimatedReturn
            dvc.TotalInvestAmount = h.SIPP_InvestedAmount
            dvc.fromScreen = "SIP_Planner"
            dvc.inflaction = h.SIPP_Inflaction
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

