//
//  Lumpsum_DisplayViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 24/03/23.
//

import UIKit
import MessageUI
import Charts
import Foundation
import AVFoundation

class Lumpsum_DisplayViewController: UIViewController, ChartViewDelegate , UITextFieldDelegate{
    
    var pie_chart = PieChartView()
    @IBOutlet weak var Total_Investment: UITextField!
    @IBOutlet weak var Rate_Of_Return: UITextField!
    @IBOutlet weak var Tenure: UITextField!
    @IBOutlet weak var Total_Value: UILabel!
    @IBOutlet weak var Estimated_Value: UILabel!
    @IBOutlet weak var Invested_Amount: UILabel!
    @IBOutlet weak var Estimated_Return_Percentage: UILabel!
    @IBOutlet weak var invested_Amount_Percentage: UILabel!
    @IBOutlet weak var value_Graph_View: UIView!
    @IBOutlet weak var Scroll_view: UIScrollView!
    @IBOutlet weak var Description_View: UIView!
    @IBOutlet weak var Pie_Chart: PieChartView!
    @IBOutlet weak var Details_Button: UIButton!
    @IBOutlet weak var Main_Colour_View: UIView!
    @IBOutlet weak var Data_Input_View: UIView!
    @IBOutlet weak var notification: UIButton!
    //    INPUT
    var TotalAmount : Double = Double()
    var RateOfReturn :  Double = Double()
    var Year : Double = Double()
    //    OUTPUT
    var ExpectedReturn : Double = Double()
    var TotalValue : Double = Double()
    
    var FinalValue : Double = Double()
    var FinalEstimatedValue : Double = Double()
    
    var EstimatedValuePercentage : Double = Double()
    var TotalInvestedAmountPercentage : Double = Double()
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
        Total_Investment.delegate = self
        Rate_Of_Return.delegate = self
        Tenure.delegate = self
        Pie_Chart.delegate = self
        value_Graph_View.isHidden = true
        Description_View.isHidden = true
        Scroll_view.isScrollEnabled = false
        Details_Button.isHidden = true
        Main_Colour_View.backgroundColor = .white
        notification.layer.zPosition = 1
        notification.layer.cornerRadius = 15
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.notification.alpha = 0
        }, completion: nil)
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if textField == Total_Investment{
//            maxLength = 10
//        } else if textField == Rate_Of_Return{
//            maxLength = 2
//        } else if textField == Tenure{
//            maxLength = 2
//        }
//
//        let currentString: NSString = textField.text! as NSString
//
//        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength
//    }
    
    @IBAction func Calculate(_ sender: UIButton) {
        if(Total_Investment.text == "" || Rate_Of_Return.text == "" || Tenure.text == "")
        {
            let all = UIAlertController(title: "SIP", message:"Please Provide Valid Information", preferredStyle: .alert)
            all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
            present(all,animated: true,completion: {return})
        }
        else
        {
            value_Graph_View.isHidden = false
            Description_View.isHidden = false
            Scroll_view.isScrollEnabled = true
            Details_Button.isHidden = false
            Main_Colour_View.backgroundColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1)
            value_Graph_View.layer.cornerRadius = 20
            Data_Input_View.layer.cornerRadius = 20
            Description_View.layer.cornerRadius = 20
            
            
            TotalAmount = Double(Total_Investment.text ?? "0.0") ?? 0.0
            RateOfReturn = Double(Rate_Of_Return.text ?? "0.0") ?? 0.0
            Year = Double(Tenure.text ?? "0.0") ?? 0.0
            if RateOfReturn > 50 {
                let all = UIAlertController(title: "SIP", message:"Please enter rate below 50%.", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                value_Graph_View.isHidden = true
                Description_View.isHidden = true
                Scroll_view.isScrollEnabled = false
                Details_Button.isHidden = true
                Main_Colour_View.backgroundColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1)
            }
            
            else
            {
                let interest = TotalAmount * pow((1.0 + (RateOfReturn/100)),Year)
                FinalValue = round(interest * 100) / 100
                
                ExpectedReturn = FinalValue - TotalAmount
                FinalEstimatedValue = round(ExpectedReturn *  100) / 100.0
                
                
                EstimatedValuePercentage = round(( (ExpectedReturn * 100) / FinalValue) * 100) / 100.0
                TotalInvestedAmountPercentage = round((100 - EstimatedValuePercentage)*100)/100.0
                
                if (FinalValue.isNaN || FinalValue <= 0)
                {
                    let all = UIAlertController(title: "SIP", message:"Please Provide Valid Information", preferredStyle: .alert)
                    all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                    present(all,animated: true,completion: {return})
                    value_Graph_View.isHidden = true
                    Description_View.isHidden = true
                    Scroll_view.isScrollEnabled = false
                    Details_Button.isHidden = true
                    Main_Colour_View.backgroundColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1)
                }
                else
                {
                    Total_Investment.resignFirstResponder()
                    Rate_Of_Return.resignFirstResponder()
                    Tenure.resignFirstResponder()
                    Total_Value.text = change(num: FinalValue)
                    Invested_Amount.text = change(num: TotalAmount)
                    Estimated_Value.text = change(num: FinalEstimatedValue)
                    Estimated_Return_Percentage.text = String(EstimatedValuePercentage) + "%"
                    invested_Amount_Percentage.text = String(TotalInvestedAmountPercentage) + "%"
                    //Pie-Chart
                    let pieChartValues = [PieChartDataEntry(value: EstimatedValuePercentage),
                                          PieChartDataEntry(value: TotalInvestedAmountPercentage)]
                    
                    let dataset = PieChartDataSet(entries: pieChartValues)
                    
                    
                    dataset.colors =  [UIColor(red: (113/255), green: (198/255), blue: (217/255), alpha: 0.7),UIColor(red: (204/255), green: (146/255), blue: (125/255), alpha: 0.7)]
                    
                    let chardata = PieChartData(dataSet: dataset)
                    
                    Pie_Chart.data = chardata
                    Pie_Chart.legend.enabled = false
                    Pie_Chart.chartDescription?.enabled = false
                    Pie_Chart.minOffset = 0
                    
                }
            }
        }
    }
    
    @IBAction func Save_Result(_ sender: Any) {
        
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
        
        h.toolId = 4;
        h.Lumpsum_TotalInvestment = TotalAmount
        h.Lumpsum_RateOfReturn = RateOfReturn
        h.Lumpsum_Year = Year
        h.Lumpsum_InvestedAmount = TotalAmount
        h.Lumpsum_ExpectedReturn = FinalEstimatedValue
        h.Lumpsum_TotalValue = FinalValue
        h.Lumpsum_Date = Lumpsum_DisplayViewController.getCurrentDate()
        let status =  Lumpsum_DisplayDAL.Add_Cal(h: h)
        print(status)
    }
    func playNotificationSound()
    {
        let url = Bundle.main.url(forResource: "notificationSound", withExtension: "caf")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
        player!.volume = 0.8
    }
    
    @IBAction func Reset(_ sender: UIButton) {
        value_Graph_View.isHidden = true
        Description_View.isHidden = true
        //        Scroll_view.isScrollEnabled = false
        Details_Button.isHidden = true
        Main_Colour_View.backgroundColor = .white
        Total_Investment.text = ""
        Rate_Of_Return.text = ""
        Tenure.text = ""
        Total_Investment.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
    }
    
    
    @IBAction func Details(_ sender: UIButton) {
        Total_Investment.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
        let dvc : Details_ViewController = storyboard?.instantiateViewController(withIdentifier: "Details_ViewController") as! Details_ViewController
        
        dvc.TotalAmount = TotalAmount
        dvc.RateOfReturn = RateOfReturn
        dvc.Tenure = Year
        dvc.TotalInvestAmount = TotalAmount
        dvc.ExpectedReturn = FinalEstimatedValue
        dvc.TotalValue = FinalValue
        dvc.fromScreen = "Lumpsum"
        self.navigationController?.pushViewController(dvc, animated: true)
        
        
    }
    
    @IBAction func Share(_ sender: Any) {
        let share = UIActivityViewController(activityItems: ["----- Lumpsum Details -----\nTotal Amount : \(change(num: TotalAmount))\nRate Of Return : \(RateOfReturn) %\nTenure(Year) : \(change(num: Year)) Years\nTotal Value : \(change(num: FinalValue))\nEstimated Retun : \(change(num: FinalEstimatedValue))\nInvested Amount : \(change(num: TotalAmount))"], applicationActivities: nil)
        share.popoverPresentationController?.sourceView = self.view
        self.present(share, animated: true,completion: nil)
        
    }
    
    @IBAction func Historys(_ sender: UIBarButtonItem) {
        //        History_ViewController
        
        let Historys : History_ViewController = storyboard?.instantiateViewController(withIdentifier: "History_ViewController") as! History_ViewController
        self.navigationController?.pushViewController(Historys, animated: true)
        
    }
}
