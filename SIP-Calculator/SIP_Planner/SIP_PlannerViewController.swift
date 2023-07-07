//
//  SIP_PlannerViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 05/04/23.
//

import UIKit
import Charts
import AVFoundation

class SIP_PlannerViewController: UIViewController, ChartViewDelegate , UITextFieldDelegate{
    var pie_chart = PieChartView()
    
    @IBOutlet weak var Expected_Amount: UITextField!
    @IBOutlet weak var Rate_Of_Return: UITextField!
    @IBOutlet weak var Tenure: UITextField!
    @IBOutlet weak var Calculate: UIButton!
    @IBOutlet weak var Reset: UIButton!
    @IBOutlet weak var Details: UIButton!
    @IBOutlet weak var Monthly_Amount: UILabel!
    @IBOutlet weak var Invested_Amount: UILabel!
    @IBOutlet weak var Estimated_Amount: UILabel!
    @IBOutlet weak var Calculation_View: UIView!
    @IBOutlet weak var Result_view: UIView!
    @IBOutlet weak var Pie_Chart: PieChartView!
    @IBOutlet weak var Invested_Amount_Percentage: UILabel!
    @IBOutlet weak var Estimated_Return_Percentage: UILabel!
    @IBOutlet weak var Main_View_Color: UIView!
    @IBOutlet weak var Description_View: UIView!
    @IBOutlet weak var Scroll_View: UIScrollView!
    @IBOutlet weak var Save_Result: UIButton!
    @IBOutlet weak var notification: UIButton!
    
    @IBOutlet weak var inflaction_Switch: UISwitch!
    @IBOutlet weak var inflaction_rate: UISegmentedControl!
    
    var ExpectedAmount : Double = Double()
    var RateOFReturn : Double = Double()
    var Year : Double = Double()
    var MonthlyAmount : Double = Double()
    var InvestedAmount : Double = Double()
    var EstimatedReturn : Double = Double()
    var rate : Double = Double()
    var EstimatedValuePercentage : Double = Double()
    var TotalInvestedAmountPercentage : Double = Double()
    var FinalMonthlyAmount : Double = Double()
    var FinalInvestedAmount : Double = Double()
    var FinalEstimatedReturn : Double = Double()
    var player : AVAudioPlayer!
    var maxLength : Int = 0
    var inflaction : Double = Double()
    var Temp_ExpectedAmount : Double = Double()
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
        inflaction_Switch.isOn = false
        inflaction_rate.isEnabled = false
        Expected_Amount.delegate = self
        Rate_Of_Return.delegate = self
        Tenure.delegate = self
        pie_chart.delegate = self
        Result_view.isHidden = true
        Description_View.isHidden = true
        Details.isHidden = true
        Main_View_Color.backgroundColor = .white
        Scroll_View.isScrollEnabled = false
        notification.layer.zPosition = 1
        notification.layer.cornerRadius = 15
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.notification.alpha = 0
        }, completion: nil)
        
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        if textField == Expected_Amount{
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
    
    @IBAction func inflaction_btn(_ sender: Any) {
        if inflaction_Switch.isOn
        {
            inflaction_rate.isEnabled = true
        }
        else
        {
            inflaction_rate.isEnabled = false
            inflaction_rate.selectedSegmentIndex = -1
        }
    }
    
    
    @IBAction func Calculate_Btn(_ sender: Any) {
        
        if(Invested_Amount.text == "" || Rate_Of_Return.text == "" || Tenure.text == "")
            
        {
            let all = UIAlertController(title: "SIP", message:"Please Provide Valid Information", preferredStyle: .alert)
            all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
            present(all,animated: true,completion: {return})
        }
        
        
        else
        {
            Result_view.isHidden = false
            Description_View.isHidden = false
            Details.isHidden = false
            Scroll_View.isScrollEnabled = true
            
            Result_view.layer.cornerRadius = 20
            //            value_Graph_View.layer.maskedCorners=[.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            Calculation_View.layer.cornerRadius = 20
//            Calculation_View.layer.maskedCorners=[.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            
            Description_View.layer.cornerRadius = 20
            //            Description_View.layer.maskedCorners=[.layerMinXMinYCorner,.layerMaxXMinYCorner]
            
            ExpectedAmount = Double(Expected_Amount.text ?? "0.0") ?? 0.0
            Temp_ExpectedAmount = ExpectedAmount
            RateOFReturn = Double(Rate_Of_Return.text ?? "0.0") ?? 0.0
            Year = Double(Tenure.text ?? "0.0") ?? 0.0
            if inflaction_rate.selectedSegmentIndex == 0
            {
                ExpectedAmount = ExpectedAmount * pow((1.04), Year) - 1
                inflaction = 4.0
            }
            else if inflaction_rate.selectedSegmentIndex == 1
            {
                ExpectedAmount = ExpectedAmount * pow((1.06), Year) - 1
                inflaction = 6.0
            }
            else if inflaction_rate.selectedSegmentIndex == 2
            {
                ExpectedAmount = ExpectedAmount * pow((1.08), Year) - 1
                inflaction = 8.0
            }
            else
            {
                ExpectedAmount = ExpectedAmount + 0
                inflaction = 0.0
            }
            rate  = (RateOFReturn/1200)
            
            
            MonthlyAmount = ExpectedAmount / (((pow(1 + rate,12*Year)-1) / rate) * (1 + rate))
            InvestedAmount = MonthlyAmount * 12 * Year
            EstimatedReturn = ExpectedAmount - InvestedAmount
            FinalMonthlyAmount = round(MonthlyAmount * 100) / 100
            FinalInvestedAmount = round(InvestedAmount * 100) / 100
            FinalEstimatedReturn = round(EstimatedReturn * 100) / 100
            
            if(MonthlyAmount.isNaN)
            {
                let all = UIAlertController(title: "SIP", message:"Please Provide Valid Information", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                Result_view.isHidden = true
                Description_View.isHidden = true
                Scroll_View.isScrollEnabled = false
                Details.isHidden = true
                Main_View_Color.backgroundColor = .white
            }
            if RateOFReturn > 50 {
                let all = UIAlertController(title: "SIP", message:"Please enter rate below 50%.", preferredStyle: .alert)
                all.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                present(all,animated: true,completion: {return})
                Result_view.isHidden = true
                Description_View.isHidden = true
                Scroll_View.isScrollEnabled = false
                Details.isHidden = true
                Main_View_Color.backgroundColor = .white
            }
            else
            {
                Expected_Amount.resignFirstResponder()
                Rate_Of_Return.resignFirstResponder()
                Tenure.resignFirstResponder()
                Estimated_Amount.text = change(num: FinalEstimatedReturn)
                Monthly_Amount.text = change(num: FinalMonthlyAmount)
                Invested_Amount.text = change(num: FinalInvestedAmount)
                let total = FinalEstimatedReturn + InvestedAmount
                EstimatedValuePercentage = round(( (FinalEstimatedReturn * 100) / total) * 10) / 10.0
                TotalInvestedAmountPercentage = round(( (InvestedAmount * 100) / total) * 10) / 10.0
                Invested_Amount_Percentage.text = String(TotalInvestedAmountPercentage) + "%"
                Estimated_Return_Percentage.text = String(EstimatedValuePercentage) + "%"
                
                let pieChartValues = [PieChartDataEntry(value: TotalInvestedAmountPercentage),
                                      PieChartDataEntry(value: EstimatedValuePercentage)]
                let dataset = PieChartDataSet(entries: pieChartValues)
                Main_View_Color.backgroundColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1)
                dataset.colors =  [UIColor(red: (113/255), green: (198/255), blue: (217/255), alpha: 0.7),UIColor(red: (204/255), green: (146/255), blue: (125/255), alpha: 0.7)]
                let chardata = PieChartData(dataSet: dataset)
                Pie_Chart.data = chardata
                Pie_Chart.legend.enabled = false
                Pie_Chart.chartDescription?.enabled = false
                Pie_Chart.minOffset = 0
                
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
        
        h.toolId = 5
        h.SIPP_ExpectedAmount = Temp_ExpectedAmount
        h.SIPP_Year = Year
        h.SIPP_RateOfReturn = RateOFReturn
        h.SIPP_EstimatedReturn = FinalEstimatedReturn
        h.SIPP_MonthlyAmount = FinalMonthlyAmount
        h.SIPP_InvestedAmount = FinalInvestedAmount
        h.SIPP_Date = SIP_PlannerViewController.getCurrentDate()
        h.SIPP_Inflaction = inflaction
        
        let status =  SIP_Planner.Add_Cal(h: h)
        print(status)
        
    }
    func playNotificationSound()
    {
        let url = Bundle.main.url(forResource: "notificationSound", withExtension: "caf")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
        player!.volume = 0.8
    }
    
    @IBAction func Reset_Btn(_ sender: Any) {
        Result_view.isHidden = true
        Description_View.isHidden = true
        //        Scroll_View.isScrollEnabled = false
        Details.isHidden = true
        Main_View_Color.backgroundColor = .white
        Expected_Amount.text = ""
        Rate_Of_Return.text = ""
        Tenure.text = ""
        inflaction_Switch.isOn = false
        inflaction_rate.selectedSegmentIndex = -1
        inflaction_rate.isEnabled = false
       
        Expected_Amount.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
        
    }
    
    @IBAction func Show_Ditails(_ sender: Any) {
        
        Expected_Amount.resignFirstResponder()
        Rate_Of_Return.resignFirstResponder()
        Tenure.resignFirstResponder()
        let dvc : Details_ViewController = storyboard?.instantiateViewController(withIdentifier: "Details_ViewController") as! Details_ViewController
        dvc.ExpectedAmount = ExpectedAmount
        dvc.RateOfReturn = RateOFReturn
        dvc.Tenure = Year
        dvc.MonthlyAmount = FinalMonthlyAmount
        dvc.ExpectedReturn = FinalEstimatedReturn
        dvc.TotalInvestAmount = FinalInvestedAmount
        dvc.inflaction = inflaction
        dvc.fromScreen = "SIP_Planner"
        
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    @IBAction func Share(_ sender: Any) {
        if(inflaction == 0.0)
        {
            let share = UIActivityViewController(activityItems: ["----- SIP Planner Details -----\nExpected Amount : \(change(num: ExpectedAmount))\nRate Of Return : \(RateOFReturn) %\nTenure(Year) : \(change(num: Year)) Years\nMonthly Amount : \(change(num: FinalMonthlyAmount))\nEstimated Retun : \(change(num: FinalEstimatedReturn))\nInvested Amount : \(change(num: FinalInvestedAmount))"], applicationActivities: nil)
            share.popoverPresentationController?.sourceView = self.view
            self.present(share, animated: true,completion: nil)
        }
        else
        {
            let share = UIActivityViewController(activityItems: ["----- SIP Planner Details -----\nExpected Amount : \(change(num: ExpectedAmount))\nInflation : \(inflaction) %\nRate Of Return : \(RateOFReturn) %\nTenure(Year) : \(change(num: Year)) Years\nMonthly Amount : \(change(num: FinalMonthlyAmount))\nEstimated Retun : \(change(num: FinalEstimatedReturn))\nInvested Amount : \(change(num: FinalInvestedAmount))"], applicationActivities: nil)
            share.popoverPresentationController?.sourceView = self.view
            self.present(share, animated: true,completion: nil)
        }
       
    }
    
    @IBAction func Historys(_ sender: UIBarButtonItem) {
        //        History_ViewController
        
        let Historys : History_ViewController = storyboard?.instantiateViewController(withIdentifier: "History_ViewController") as! History_ViewController
        self.navigationController?.pushViewController(Historys, animated: true)
        
    }
    
}
