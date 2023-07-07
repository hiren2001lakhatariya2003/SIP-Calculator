//
//  SIP_Display_ViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 28/02/2023.
//
import Charts
import UIKit
import MessageUI
import Foundation
import AVFoundation
import StoreKit
import UserNotifications
class SIP_Display_ViewController: UIViewController, ChartViewDelegate, UITextFieldDelegate{
    var pie_chart = PieChartView()
    
    @IBOutlet weak var Monthly_Amount: UITextField!
    @IBOutlet weak var Rate_Of_Return: UITextField!
    @IBOutlet weak var Tenure: UITextField!
    @IBOutlet weak var Total_Invest_Amount: UILabel!
    @IBOutlet weak var Expected_Return: UILabel!
    @IBOutlet weak var Total_Value: UILabel!
    @IBOutlet weak var Estimated_Return_Percentage: UILabel!
    @IBOutlet weak var invested_Amount_Percentage: UILabel!
    @IBOutlet weak var value_Graph_View: UIView!
    @IBOutlet weak var Description_view: UIView!
    @IBOutlet weak var Scroll_view: UIScrollView!
    @IBOutlet weak var Details_button: UIButton!
    @IBOutlet weak var Main_View_Color: UIView!
    @IBOutlet weak var data_Input_View: UIView!
    @IBOutlet weak var Pie_Chart_View: PieChartView!
    @IBOutlet weak var Save_Result: UIButton!
    @IBOutlet weak var notification: UIButton!
    
    var player : AVAudioPlayer!
    //   INPUT
    var MonthlyAmount : Double = Double()
    var RateOfReturn :  Double = Double()
    var Year : Double = Double()
    //    OUTPUT
    var TotalInvestAmount : Double = Double()
    var ExpectedReturn : Double = Double()
    var TotalValue : Double = Double()
    var rate: Double = Double()
    // finalRoundOf
    var finalValue : Double = Double()
    var FinalEstimatedValue : Double = Double()
    var EstimatedValuePercentage : Double = Double()
    var TotalInvestedAmountPercentage : Double = Double()
    var maxLength : Int = 0
    static func getCurrentDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy - hh:mm a"
        return dateFormatter.string(from: Date())
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Monthly_Amount.delegate = self
        Rate_Of_Return.delegate = self
        Tenure.delegate = self
        pie_chart.delegate = self
        
        value_Graph_View.isHidden = true
        Description_view.isHidden = true
        Scroll_view.isScrollEnabled = false
        Details_button.isHidden = true
        Main_View_Color.backgroundColor = .white
        notification.layer.zPosition = 1
        notification.layer.cornerRadius = 15
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.notification.alpha = 0
        }, completion: nil)
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        SKStoreReviewController.requestReview()
//    }
    
    

    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//       
//        let currentString: NSString = textField.text! as NSString
//        
//        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength
//    }
    func change(num: Double) -> String
    {
        let formatter = NumberFormatter()              // Cache this, NumberFormatter creation is expensive.
        formatter.locale = Locale(identifier: "en_IN") // Here indian locale with english language is used
        formatter.numberStyle = .decimal               // Change to `.currency` if needed
        
        let asd = formatter.string(from: NSNumber(value: round(num * 1) / 1)) ?? ""
        return asd
        
    }
    
    @IBAction func SIP_Calculate(_ sender: UIButton) {
        
        if(Monthly_Amount.text == "" || Rate_Of_Return.text == "" || Tenure.text == "")
            
        {
            let all = UIAlertController(title: "SIP", message:"Please provide valid information.", preferredStyle: .alert)
            all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
            present(all,animated: true,completion: {return})
        }
        
        else
        {
            value_Graph_View.isHidden = false
            Description_view.isHidden = false
            Scroll_view.isScrollEnabled = true
            Details_button.isHidden = false
            
            value_Graph_View.layer.cornerRadius = 20
            data_Input_View.layer.cornerRadius = 20
            Description_view.layer.cornerRadius = 20
            
            MonthlyAmount = Double(Monthly_Amount.text ?? "0.0") ?? 0.0
            RateOfReturn = Double(Rate_Of_Return.text ?? "0.0") ?? 0.0
            Year = Double(Tenure.text ?? "0") ?? 0
            if RateOfReturn > 50 {
                let all = UIAlertController(title: "SIP", message:"Please enter rate below 50%.", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                value_Graph_View.isHidden = true
                Description_view.isHidden = true
                Scroll_view.isScrollEnabled = false
                Details_button.isHidden = true
                Main_View_Color.backgroundColor = .white
            }
            else if Year > 90 {
                let all = UIAlertController(title: "SIP", message:"Please enter Tenure below 90%.", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                value_Graph_View.isHidden = true
                Description_view.isHidden = true
                Scroll_view.isScrollEnabled = false
                Details_button.isHidden = true
                Main_View_Color.backgroundColor = .white
            }
            else
            {
                
                rate  = (RateOfReturn/1200)
                // calculation
                TotalInvestAmount = MonthlyAmount * 12 * Year
                TotalValue = MonthlyAmount * ((pow(1 + rate,12*Year)-1) / rate) * (1 + rate)
                
                //round of
                finalValue = round(TotalValue * 100) / 100.0
                ExpectedReturn = finalValue - TotalInvestAmount
                FinalEstimatedValue = round(ExpectedReturn *  100) / 100.0
                
                //persentage value
                EstimatedValuePercentage = round(( (ExpectedReturn * 100) / finalValue) * 100) / 100.0
                TotalInvestedAmountPercentage = round((100 - EstimatedValuePercentage)*100)/100.0
                
                if (finalValue.isNaN || finalValue <= 0)
                {
                    let all = UIAlertController(title: "SIP", message:"Please Provide Valid Information", preferredStyle: .alert)
                    all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                    present(all,animated: true,completion: {return})
                    value_Graph_View.isHidden = true
                    Description_view.isHidden = true
                    Scroll_view.isScrollEnabled = false
                    Details_button.isHidden = true
                    Main_View_Color.backgroundColor = .white
                }
                else
                {
                    
                    Monthly_Amount.resignFirstResponder()
                    Rate_Of_Return.resignFirstResponder()
                    Tenure.resignFirstResponder()
                    Total_Value.text = change(num: TotalValue)
                    Total_Invest_Amount.text = change(num: TotalInvestAmount)
                    Expected_Return.text = change(num: FinalEstimatedValue)
                    Estimated_Return_Percentage.text = String(EstimatedValuePercentage) + "%"
                    invested_Amount_Percentage.text = String(TotalInvestedAmountPercentage) + "%"
                    
                    let pieChartValues = [PieChartDataEntry(value: EstimatedValuePercentage),
                                          PieChartDataEntry(value: TotalInvestedAmountPercentage)]
                    
                    let dataset = PieChartDataSet(entries: pieChartValues)
                    
                    Main_View_Color.backgroundColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1)
                    dataset.colors =  [UIColor(red: (113/255), green: (198/255), blue: (217/255), alpha: 0.7),UIColor(red: (204/255), green: (146/255), blue: (125/255), alpha: 0.7)]
                    
                    let chardata = PieChartData(dataSet: dataset)
                    
                    Pie_Chart_View.data = chardata
                    Pie_Chart_View.legend.enabled = false
                    Pie_Chart_View.chartDescription?.enabled = false
                    Pie_Chart_View.minOffset = 0
                    
                }
            }
            
        }
    }
    
    
    @IBAction func Save_Results(_ sender: UIButton) {
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
        h.toolId = 1
        h.SIP_MonthlyAmount = MonthlyAmount
        h.SIP_RateOfReturn = RateOfReturn
        h.SIP_Year = Year
        h.SIP_TotalValue = finalValue
        h.SIP_ExpectedReturn = FinalEstimatedValue
        h.SIP_TotalInvestAmount = TotalInvestAmount
        h.SIP_Date = SIP_Display_ViewController.getCurrentDate()
        
        let status =  SIP_DisplayDAL.Add_Cal(h: h)
        print(status)
    }
    
    func playNotificationSound()
    {
        let url = Bundle.main.url(forResource: "notificationSound", withExtension: "caf")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
        player!.volume = 0.8
       
        
    }
    @IBAction func clear(_ sender: Any) {
        value_Graph_View.isHidden = true
        Description_view.isHidden = true
        //        Scroll_view.isScrollEnabled = false
        Details_button.isHidden = true
        Main_View_Color.backgroundColor = .white
        Monthly_Amount.text = ""
        Rate_Of_Return.text = ""
        Tenure.text = ""
        Monthly_Amount.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
    }
    
    
    @IBAction func Details(_ sender: Any) {
        Monthly_Amount.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
        let dvc : Details_ViewController = storyboard?.instantiateViewController(withIdentifier: "Details_ViewController") as! Details_ViewController
        
        dvc.MonthlyAmount = MonthlyAmount
        dvc.RateOfReturn = RateOfReturn
        dvc.Tenure = Year
        dvc.TotalInvestAmount = TotalInvestAmount
        dvc.ExpectedReturn = ExpectedReturn
        dvc.TotalValue = TotalValue
        
        dvc.fromScreen = "SIP"
        
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
    
//
//    @IBAction func Send_Message(_ sender: Any) {
//        guard MFMessageComposeViewController.canSendText() else{
//            print("Device is not capable to send message")
//            return
//        }
//        let composer = MFMessageComposeViewController()
//        composer.messageComposeDelegate = self
//        composer.recipients = ["12345678"]
//        composer.subject = "hello Composer"
//        present(composer,animated: true)
//
//    }
//    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
//
//        switch result {
//        case .cancelled:
//            print("Cancel")
//        case .failed:
//            print("failed")
//        case .sent:
//            print("sent")
//        default:
//            print("Unknown")
//        }
//        controller.dismiss(animated: true)
//    }
    
    
    @IBAction func Share(_ sender: Any) {
        let share = UIActivityViewController(activityItems: ["----- SIP Details -----\nMonthly Amount : \(change(num: MonthlyAmount))\nRate Of Return : \(RateOfReturn) %\nTenure(Year) : \(change(num: Year)) Years\nTotal Value : \(change(num: finalValue))\nEstimated Retun : \(change(num: FinalEstimatedValue))\nInvested Amount : \(change(num: TotalInvestAmount))"], applicationActivities: nil)
        share.popoverPresentationController?.sourceView = self.view
        self.present(share, animated: true,completion: nil)
    }
    @IBAction func Historys(_ sender: UIBarButtonItem) {
        //        History_ViewController
        
        let Historys : History_ViewController = storyboard?.instantiateViewController(withIdentifier: "History_ViewController") as! History_ViewController
        self.navigationController?.pushViewController(Historys, animated: true)
        
    }
    
}

