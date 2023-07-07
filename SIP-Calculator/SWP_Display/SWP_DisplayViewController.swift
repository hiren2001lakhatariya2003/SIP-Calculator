//
//  SWP_DisplayViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 23/03/23.
//

import UIKit
import Charts
import MessageUI
import AVFoundation
class SWP_DisplayViewController: UIViewController,ChartViewDelegate, UITextFieldDelegate {
    var line_chart = LineChartView()
    var returns : [Int] = [];
    var FinalBalances : [Int] = [];
    
    @IBOutlet weak var Total_Invested_Amount: UITextField!
    @IBOutlet weak var Withdrawal_Amount: UITextField!
    @IBOutlet weak var Rate_Of_Return: UITextField!
    @IBOutlet weak var Tenure: UITextField!
    @IBOutlet weak var Calculate: UIButton!
    @IBOutlet weak var Reset: UIButton!
    @IBOutlet weak var Details_Button: UIButton!
    @IBOutlet weak var Calculation_View: UIView!
    @IBOutlet weak var Button_View: UIView!
    @IBOutlet weak var Reesult_Display_view: UIView!
    @IBOutlet weak var Final_Balance: UILabel!
    @IBOutlet weak var Share_Message: UIButton!
    @IBOutlet weak var Total_Withdrawal: UILabel!
    @IBOutlet weak var Estimated_Return: UILabel!
    @IBOutlet weak var Description_View: UIView!
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var notification: UIButton!
    
    var totalInvestedAmount : Double = Double()
    var withdrawalAmount : Double = Double()
    var RateOfReturn : Double = Double()
    var Year : Double = Double()
    var FinalBalance : Double = Double()
    var EstimatedReturn : Double = Double()
    var Display_TotalInvested : Double = Double()
    var totalWithdrawal : Double = Double()
    var Final_Display_Balance : Double = Double()
    var Final_Display_EstimatedReturn : Double = Double()
    var FinalWithdrawalAmount : Double = Double()
    var rowCount = 0
    var player : AVAudioPlayer!
    var maxLength : Int = 0
    
    func change(num: Double) -> String
    {
        let formatter = NumberFormatter()              // Cache this, NumberFormatter creation is expensive.
        formatter.locale = Locale(identifier: "en_IN") // Here indian locale with english language is used
        formatter.numberStyle = .decimal               // Change to `.currency` if needed
        
        let asd = formatter.string(from: NSNumber(value: round(num * 1) / 1)) ?? ""
        return asd
        
    }
    
    static func getCurrentDate() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy - hh:mm a"
        
        return dateFormatter.string(from: Date())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Total_Invested_Amount.delegate = self
        Rate_Of_Return.delegate = self
        Tenure.delegate = self
        Withdrawal_Amount.delegate = self
        line_chart.delegate = self
        Reesult_Display_view.isHidden = true
        Description_View.isHidden = true
        scroll_view.isScrollEnabled = false
        Details_Button.isHidden = true
        main_view.backgroundColor = .white
        notification.layer.zPosition = 1
        notification.layer.cornerRadius = 15
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.notification.alpha = 0
        }, completion: nil)
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//
//
//        let currentString: NSString = textField.text! as NSString
//
//        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength
//    }e
    
    @IBAction func Calculate_SWP(_ sender: UIButton) {
        
        
        if(Total_Invested_Amount.text == "" || Withdrawal_Amount.text == "" || Rate_Of_Return.text == "" || Tenure.text == "" || Tenure.text == "0")
        {
            let all = UIAlertController(title: "SIP", message:"Please Provide Valid Information", preferredStyle: .alert)
            all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
            present(all,animated: true,completion: {return})
            
        }
        
        else
        {
            rowCount = 0
            Reesult_Display_view.isHidden = false
            Description_View.isHidden = false
            scroll_view.isScrollEnabled = true
            Details_Button.isHidden = false
            main_view.backgroundColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1)
            Reesult_Display_view.layer.cornerRadius = 20
            Calculation_View.layer.cornerRadius = 20
            
            Description_View.layer.cornerRadius = 20
            //            Description_View.layer.maskedCorners=[.layerMinXMinYCorner,.layerMaxXMinYCorner]
            
            totalInvestedAmount = Double(Total_Invested_Amount.text ?? "0.0") ?? 0.0
            Display_TotalInvested = totalInvestedAmount
            withdrawalAmount = Double(Withdrawal_Amount.text ?? "0.0") ?? 0.0
            RateOfReturn = Double(Rate_Of_Return.text ?? "0.0") ?? 0.0
            Year = Double(Tenure.text ?? "0.0") ?? 0.0
            if(withdrawalAmount >= totalInvestedAmount && RateOfReturn <= 50)
            {
                let all = UIAlertController(title: "SIP", message:"Withdrawal amount can not exceed Totol invested amount.", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                Reesult_Display_view.isHidden = true
                Description_View.isHidden = true
                scroll_view.isScrollEnabled = false
                Details_Button.isHidden = true
                main_view.backgroundColor = .white
            }
            else if(withdrawalAmount >= totalInvestedAmount && RateOfReturn > 50)
            {
                let all = UIAlertController(title: "SIP", message:"Withdrawal amount can not exceed Totol invested amount.", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                Reesult_Display_view.isHidden = true
                Description_View.isHidden = true
                scroll_view.isScrollEnabled = false
                Details_Button.isHidden = true
                main_view.backgroundColor = .white
            }
            else if(RateOfReturn > 50 && withdrawalAmount < totalInvestedAmount)
            {
                let all = UIAlertController(title: "SIP", message:"Please enter rate below 50%.", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                Reesult_Display_view.isHidden = true
                Description_View.isHidden = true
                scroll_view.isScrollEnabled = false
                Details_Button.isHidden = true
                main_view.backgroundColor = .white
            }
            totalWithdrawal = withdrawalAmount * 12 * Year
            let totalUnits = Int(12 * Year)
            var EstimatedReturn  = 0.0
            var FinalEstimatedReturn = 0.0
            var saveEstimatedResult = 0.0
            var TOTALWITHDRAWAL = 0.0
            
            for i in 1..<totalUnits+1
            {
                let restAmount = totalInvestedAmount - withdrawalAmount
                
                let returns = round(restAmount * ( RateOfReturn / 1200) * 100) / 100
                
                TOTALWITHDRAWAL = TOTALWITHDRAWAL + withdrawalAmount
                
                EstimatedReturn = EstimatedReturn +  returns
                if(i % 12 != 0)
                {
                    totalInvestedAmount = restAmount
                    rowCount = rowCount + 1
                    saveEstimatedResult = saveEstimatedResult + returns
                    if(totalInvestedAmount <= withdrawalAmount)
                    {   TOTALWITHDRAWAL = TOTALWITHDRAWAL + totalInvestedAmount
                        print(TOTALWITHDRAWAL)
                        totalInvestedAmount = 0
                        
                        break;
                    }
                    
                    print(returns,"----",restAmount,"----",saveEstimatedResult)
                    
                    
                }
                else if(i == totalUnits+1)
                {
                    
                    totalInvestedAmount = restAmount + FinalEstimatedReturn + EstimatedReturn
                    
                    saveEstimatedResult = saveEstimatedResult + returns
                    if(totalInvestedAmount <= withdrawalAmount)
                    {
                        TOTALWITHDRAWAL = TOTALWITHDRAWAL + totalInvestedAmount
                        print(TOTALWITHDRAWAL)
                        totalInvestedAmount = 0
                        break;
                    }
                    
                    print(returns,"----",totalInvestedAmount,"----",saveEstimatedResult)
                    
                }
                else
                {
                    totalInvestedAmount = restAmount + EstimatedReturn
                    
                    print(returns,"----",totalInvestedAmount)
                    saveEstimatedResult = saveEstimatedResult + returns
                    
                    EstimatedReturn = 0.0
                    FinalEstimatedReturn = EstimatedReturn
                    rowCount = rowCount + 1
                    if(totalInvestedAmount <= withdrawalAmount)
                    {
                        
                        print(TOTALWITHDRAWAL)
                        
                        break;
                    }
                }
                
                
            }
            
            
            FinalWithdrawalAmount = TOTALWITHDRAWAL
            
            
            let FinalBalance = round(totalInvestedAmount * 100) / 100
            let finalEstimatedReturn = round(saveEstimatedResult * 100 ) / 100
            
            Total_Withdrawal.text = change(num: FinalWithdrawalAmount)
            Final_Balance.text = change(num: FinalBalance)
            Estimated_Return.text = change(num: finalEstimatedReturn)
            Final_Display_Balance = FinalBalance
            Final_Display_EstimatedReturn = finalEstimatedReturn
            Total_Invested_Amount.resignFirstResponder()
            Withdrawal_Amount.resignFirstResponder()
            Rate_Of_Return.resignFirstResponder()
            Tenure.resignFirstResponder()
            
        }
    }
    
    @IBAction func Save_Result(_ sender: UIButton) {
        self.playNotificationSound()
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.notification.alpha = 1.0
        }, completion: {
            (finished: Bool) -> Void in
            //Once the label is completely invisible, set the text and fade it back in
            // Fade in
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.notification.alpha = 0.0
            }, completion: nil)
        })
        
        let h : History = History()
        h.toolId = 3
        h.SWP_TotalInvestment = Display_TotalInvested
        h.SWP_WithdrawalAmount = withdrawalAmount
        h.SWP_RateOfReturn = RateOfReturn
        h.SWP_Year = Year
        h.SWP_FinalBalance = Final_Display_Balance
        h.SWP_ExpectedReturn = Final_Display_EstimatedReturn
        h.SWP_TotalWithdrawals = FinalWithdrawalAmount
        h.SWP_Count = rowCount
        h.SWP_Date = SWP_DisplayViewController.getCurrentDate()
        
        let status = SWP_DisplayDal.Add_Cal(h: h)
        print(status)
        
    }
    
    
    @IBAction func Reset(_ sender: UIButton) {
        Reesult_Display_view.isHidden = true
        Description_View.isHidden = true
        Details_Button.isHidden = true
        //        scroll_view.isScrollEnabled = false
        main_view.backgroundColor = .white
        Total_Invested_Amount.text = ""
        Withdrawal_Amount.text = ""
        Rate_Of_Return.text = ""
        Tenure.text = ""
        Total_Invested_Amount.resignFirstResponder()
        Withdrawal_Amount.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
        
    }
    
    @IBAction func Details(_ sender: UIButton) {
        Total_Invested_Amount.resignFirstResponder()
        Withdrawal_Amount.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
        let SWPdvc : SWP_DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "SWP_DetailsViewController") as! SWP_DetailsViewController
        
        SWPdvc.totalInvestedAmount = Display_TotalInvested
        SWPdvc.withdrawalAmount = withdrawalAmount
        SWPdvc.RateOfReturn = RateOfReturn
        SWPdvc.Year = Year
        SWPdvc.FinalBalance = Final_Display_Balance
        SWPdvc.EstimatedReturn = Final_Display_EstimatedReturn
        SWPdvc.totalWithdrawal = FinalWithdrawalAmount
        SWPdvc.cell_count = (Int32(Year) * 12);
        SWPdvc.Count = rowCount
        self.navigationController?.pushViewController(SWPdvc, animated: true)
        
    }
    
    @IBAction func Share(_ sender: UIButton) {
        let share = UIActivityViewController(activityItems: ["----- SWP Details -----\nTotal Investment : \(change(num: Display_TotalInvested))\nWithdrawal Amount : \(change(num: withdrawalAmount))\nRate Of Return : \(RateOfReturn) %\nTenure(Year) : \(change(num: Year)) Years\nFinal Balance : \(change(num: Final_Display_Balance))\nEstimated Return : \(change(num: Final_Display_EstimatedReturn))\nTotal Withdrawal : \(change(num: FinalWithdrawalAmount))"], applicationActivities: nil)
        share.popoverPresentationController?.sourceView = self.view
        self.present(share, animated: true,completion: nil)
    }
    
    @IBAction func Historys(_ sender: UIBarButtonItem) {
        
        let Historys : History_ViewController = storyboard?.instantiateViewController(withIdentifier: "History_ViewController") as! History_ViewController
        self.navigationController?.pushViewController(Historys, animated: true)
        
    }
    func playNotificationSound()
    {
        let url = Bundle.main.url(forResource: "notificationSound", withExtension: "caf")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
        player!.volume = 0.8
    }
    
}
