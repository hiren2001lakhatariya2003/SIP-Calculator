//
//  Details_ViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 18/03/23.
//

import UIKit
import Foundation
import WebKit

class Details_ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate, WKUIDelegate{
    var history : [History] = []
    var years : [Double] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    var year_for_sipp : [Int] = []
    // INPUT
    var MonthlyAmount : Double = Double(); //for SIP
    var TotalAmount : Double = Double(); // for Lumpsum
    // Common
    var RateOfReturn :  Double = Double();
    var Tenure : Double = Double();
    //    OUTPUT
    var TotalInvestAmount : Double = Double();
    var ExpectedReturn : Double = Double();
    var TotalValue : Double = Double();
    var ExpectedAmount : Double = Double()
    // FOR HTML PREVIEW
    var html :  String  = String()
    var table1_S : String = String()
    var table2_S : String = String()
    var head_S : String = String()
    var head_E : String = String()
    var row_S : String = String()
    var row_E : String = String()
    var table1_E : String = String()
    var table2_E : String = String()
    var htmlEnding : String = String()
    var newLine : String = String()
    var inflaction : Double = Double()
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var Monthly_Amount: UILabel!
    @IBOutlet weak var Rate_Of_Return: UILabel!
    @IBOutlet weak var Total_Value: UILabel!
    @IBOutlet weak var Expected_Return: UILabel!
    @IBOutlet weak var Total_Invested_Amount: UILabel!
    @IBOutlet weak var Year: UILabel!
    @IBOutlet weak var vertical_Stack: UIStackView!
    @IBOutlet weak var h_st1: UIStackView!
    @IBOutlet weak var h_st2: UIStackView!
    @IBOutlet weak var h_st3: UIStackView!
    @IBOutlet weak var h_st4: UIStackView!
    @IBOutlet weak var h_st5: UIStackView!
    @IBOutlet weak var h_st6: UIStackView!
    
    @IBOutlet weak var h1s1: UIStackView!
    @IBOutlet weak var h2s1: UIStackView!
    @IBOutlet weak var h3s1: UIStackView!
    @IBOutlet weak var h4s1: UIStackView!
    @IBOutlet weak var h5s1: UIStackView!
    @IBOutlet weak var h6s1: UIStackView!
    
    @IBOutlet weak var h1s2: UIStackView!
    @IBOutlet weak var h2s2: UIStackView!
    @IBOutlet weak var h3s2: UIStackView!
    @IBOutlet weak var h5s2: UIStackView!
    @IBOutlet weak var h6s2: UIStackView!
    @IBOutlet weak var h4s2: UIStackView!
    
    @IBOutlet weak var Monthly_Amount_Change: UILabel!
    
    let margin_left : CGFloat = CGFloat(8)
    let margin_right : CGFloat = CGFloat(0)
    let margin_top : CGFloat = CGFloat(0)
    let margin_bottom : CGFloat = CGFloat(0)
    var yearCalculate : Int = Int()
    var stringFormate : String = String()
    var fromScreen = ""
    
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
        if ( number >= 1000.000 && number < 100000.000)
        {
            number = number / 1000.000
            number = round(number * 100) / 100
            stringFormate = String(number) + " K"
        }
        else if( number >= 100000.000 && number < 100000000.00)
        {
            number = number / 100000.000
            number = round(number * 100) / 100
            stringFormate =  String(number) + " L"
        }
        else if( number >= 100000000.000)
        {
            number = number / 10000000.000
            number = round(number * 100) / 100
            stringFormate = String(number) + " Cr"
        }
        return stringFormate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        html = "<!DOCTYPE html> <html> <head> <title>Table with Rounded Corners</title> <style> body {font-family: sans-serif; } h1 {color: rgb(160, 113, 116); text-align: center; } h4{text-align: center; } #table1 {border: 1px solid black; text-align: left; border-radius: 10px; width: 350px; } #table2 {border: 1px solid black; text-align: left; border-radius: 10px; width: 600px; } td {border: 1px solid black; text-align: left; padding: 5px; } .o {width: 50%; } .t {width: 33.3333%; text-align: center; } #o-o {border-radius: 8px 0 0 0; } #o-t {border-radius:0 8px 0 0; } #s-o {border-radius: 0 0 0 8px; } #s-t {border-radius:0 0 8px 0; } .color {background-color: rgb(190, 169, 160); } </style> </head> <body>"
        htmlEnding = "<h4>hello</h4></body></html>"
        table1_S = "<table cellspacing='0' align='center' id = 'table1'>"
        table1_E = "</table>"
        table2_S = "<table cellspacing='0' align='center' id = 'table2'>"
        table2_E = "</table>"
        head_S = "<th>"
        head_E = "</th>"
        row_S = "<tr>"
        row_E = "</tr>"
        newLine = "<br>"
        
        yearCalculate = Int(Tenure)
        
        for i in 0..<yearCalculate+1
        {
            year_for_sipp.append(i)
        }
        //FIRST TABLE
        
        if fromScreen == "SIP"
        {
            self.title = "Details"
            html += "<h1> SIP Details </h1>"
            html += table1_S + row_S + "<td id = 'o-o' class='o'>Monthly Amount</td><td  id = 'o-t'>\(change(num: MonthlyAmount))</td>" + row_E
            html += row_S + "<td class='o'>Exp. Return Rate(%)</td><td class='o'>\(RateOfReturn) %</td>" + row_E
            html += row_S + "<td class='o'>Tenure(Year)</td><td class='o'>\(Int(Tenure)) Years</td>" + row_E
            html += row_S + "<td class='o'>Invested Amount</td><td class='o'>\(change(num: TotalInvestAmount))</td>" + row_E
            html += row_S + "<td class='o'>Estimated Return</td><td class='o'>\(change(num: ExpectedReturn))</td>" + row_E
            html += row_S + "<td  id = 's-o' class='o'>Total Value</td><td id = 's-t' class='o'>\(change(num: TotalValue))</td>" + row_E + table1_E + newLine
            
            Monthly_Amount.text = change(num: MonthlyAmount)
            Total_Value.text = change(num: TotalValue)
            Total_Invested_Amount.text = change(num: TotalInvestAmount)
            Expected_Return.text = change(num: ExpectedReturn)
            
            Rate_Of_Return.text = String(RateOfReturn) + " %"
            Year.text = String(Int(Tenure)) + " Years"
            
            print(html)
        }
        
        if fromScreen == "Lumpsum"
        {
            html += "<h1> Lumpsum Details </h1>"
            html += table1_S + row_S + "<td id = 'o-o' class='o'>Monthly Amount</td><td  id = 'o-t'>\(change(num: TotalAmount))</td>" + row_E
            html += row_S + "<td class='o'>Exp. Return Rate(%)</td><td class='o'>\(RateOfReturn) %</td>" + row_E
            html += row_S + "<td class='o'>Tenure(Year)</td><td class='o'>\(Int(Tenure)) Years</td>" + row_E
            html += row_S + "<td class='o'>Invested Amount</td><td class='o'>\(change(num: TotalInvestAmount))</td>" + row_E
            html += row_S + "<td class='o'>Estimated Return</td><td class='o'>\(change(num: ExpectedReturn))</td>" + row_E
            html += row_S + "<td  id = 's-o' class='o'>Total Value</td><td id = 's-t' class='o'>\(change(num: TotalValue))</td>" + row_E + table1_E + newLine
            
            Monthly_Amount.text = change(num: TotalAmount)
            Total_Value.text = change(num: TotalValue)
            Total_Invested_Amount.text = change(num: TotalInvestAmount)
            Expected_Return.text = change(num: ExpectedReturn)
            
            self.title = "Details"
            Monthly_Amount_Change.text = "Total Investment"
            Rate_Of_Return.text = String(RateOfReturn) + " %"
            Year.text = String(Int(Tenure)) + " Years"
            
        }
        if fromScreen == "SIP_Planner"
        {
            self.title = "Details"
            html += "<h1> SIP Planner Details </h1>"
            
            html += table1_S + row_S + "<td id = 'o-o' class='o'>Monthly Amount</td><td  id = 'o-t'>\(change(num: MonthlyAmount))</td>" + row_E
            html += row_S + "<td class='o'>Exp. Return Rate(%)</td><td class='o'>\(RateOfReturn) %</td>" + row_E
            html += row_S + "<td class='o'>Tenure(Year)</td><td class='o'>\(Int(Tenure)) Years</td>" + row_E
            html += row_S + "<td class='o'>Invested Amount</td><td class='o'>\(change(num: TotalInvestAmount))</td>" + row_E
            html += row_S + "<td class='o'>Estimated Return</td><td class='o'>\(change(num: ExpectedReturn))</td>" + row_E
            if(inflaction != 0.0)
            {
                html += row_S + "<td  id = 's-o' class='o'>Total Value</td><td id = 's-t' class='o'>\(change(num: ExpectedAmount)) - with Inflation : \(inflaction) %</td>" + row_E + table1_E + newLine
            }
           
            
            Total_Invested_Amount.text = change(num: TotalInvestAmount)
            Rate_Of_Return.text = String(RateOfReturn) + " %"
            Year.text = String(Int(Tenure)) + " Years"
            Monthly_Amount.text = change(num: MonthlyAmount)
            if(inflaction != 0.0)
            {
                Total_Value.text = change(num: ExpectedAmount) + " - with Inflation : \(inflaction) %"
            }
            else
            {
                Total_Value.text = change(num: ExpectedAmount)
            }
            Expected_Return.text = change(num: ExpectedReturn)
            print(year_for_sipp)
            print(html)
            
        }
        vertical_Stack.layer.cornerRadius = 10
        vertical_Stack.layer.borderWidth = 1
        h_st2.layer.borderWidth = 0.5
        h_st4.layer.borderWidth = 0.5
        h_st6.layer.borderWidth = 0.5
        h_st6.layer.cornerRadius = 10
        h_st6.layer.maskedCorners=[.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        
        h1s1.layer.borderWidth = 0.5 // 1 side
        h1s1.layer.cornerRadius = 10
        h1s1.layoutMargins = UIEdgeInsets(top:margin_top , left: margin_left, bottom:margin_bottom , right:margin_right )
        h1s1.isLayoutMarginsRelativeArrangement = true
        h1s1.layer.maskedCorners = [.layerMinXMinYCorner]
        
        h2s1.layer.borderWidth = 0.5
        h2s1.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left, bottom: margin_bottom, right: margin_right)
        h2s1.isLayoutMarginsRelativeArrangement = true
        
        h3s1.layer.borderWidth = 0.5
        h3s1.layoutMargins = UIEdgeInsets(top:margin_top , left: margin_left, bottom: margin_bottom, right: margin_right)
        h3s1.isLayoutMarginsRelativeArrangement = true
        
        h4s1.layer.borderWidth = 0.5
        h4s1.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left, bottom: margin_bottom, right: margin_right)
        h4s1.isLayoutMarginsRelativeArrangement = true
        
        h5s1.layer.borderWidth = 0.5
        h5s1.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left, bottom: margin_bottom, right: margin_right)
        h5s1.isLayoutMarginsRelativeArrangement = true
        
        h6s1.layer.borderWidth = 0.5
        h6s1.layer.cornerRadius = 10
        h6s1.layer.maskedCorners = [.layerMinXMaxYCorner]
        h6s1.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left , bottom: margin_bottom, right: margin_right)
        h6s1.isLayoutMarginsRelativeArrangement = true
        
        h1s2.layer.cornerRadius = 10
        h1s2.layer.borderWidth = 0.5 // 2 side
        h1s2.layer.maskedCorners = [.layerMaxXMinYCorner]
        h1s2.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left , bottom: margin_bottom, right: margin_right)
        h1s2.isLayoutMarginsRelativeArrangement = true
        
        h2s2.layer.borderWidth = 0.5
        h2s2.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left , bottom: margin_bottom, right: margin_right)
        h2s2.isLayoutMarginsRelativeArrangement = true
        
        h3s2.layer.borderWidth = 0.5
        h3s2.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left , bottom: margin_bottom, right: margin_right)
        h3s2.isLayoutMarginsRelativeArrangement = true
        
        h4s2.layer.borderWidth = 0.5
        h4s2.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left , bottom: margin_bottom, right: margin_right)
        h4s2.isLayoutMarginsRelativeArrangement = true
        
        h5s2.layer.borderWidth = 0.5
        h5s2.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left , bottom: margin_bottom, right: margin_right)
        h5s2.isLayoutMarginsRelativeArrangement = true
        
        h6s2.layer.borderWidth = 0.5
        h6s2.layer.cornerRadius = 10
        h6s2.layer.maskedCorners = [.layerMaxXMaxYCorner]
        h6s2.layoutMargins = UIEdgeInsets(top: margin_top, left: margin_left , bottom: margin_bottom, right: margin_right)
        h6s2.isLayoutMarginsRelativeArrangement = true
        
        html += table2_S
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : Details_TableTableViewCell = tableView.dequeueReusableCell(withIdentifier: "details", for: indexPath) as! Details_TableTableViewCell
        
        if indexPath.row == 0
        {
            if fromScreen == "SIP" || fromScreen == "Lumpsum"
            {
                cell.backgroundColor = UIColor(red: (190/255), green: (169/255), blue: (160/255), alpha: 1)
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
                cell.Years.layer.cornerRadius = 10
                cell.Years.layer.maskedCorners = [.layerMinXMinYCorner]
                
                cell.Years.layer.borderWidth = 1
                cell.Future_Value.layer.borderWidth = 1
                cell.Invested.layer.borderWidth = 1
                cell.layer.borderWidth = 1
                cell.Years.text = "Years"
                cell.Future_Value.text = "Future Value"
                cell.Invested.text = "Invested"
                
                html += row_S + "<td id = 'o-o' class='color t'>Years</td><td class='color t'>Invested</td><td id = 'o-t' class='color t'>Future Value</td>" + row_E
                
                
                
            }
            if fromScreen == "SIP_Planner"
            {
                cell.backgroundColor = UIColor(red: (190/255), green: (169/255), blue: (160/255), alpha: 1)
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
                cell.Years.layer.cornerRadius = 10
                cell.Years.layer.maskedCorners = [.layerMinXMinYCorner]
                
                cell.Years.layer.borderWidth = 1
                cell.Future_Value.layer.borderWidth = 1
                cell.Invested.layer.borderWidth = 1
                cell.layer.borderWidth = 1
                cell.Years.text = "Years"
                cell.Future_Value.text = "Future Value"
                cell.Invested.text = "SIP Amount"
                
                html += row_S + "<td id = 'o-o' class='color t'>Years</td><td class='color t'>SIP Amount</td><td id = 'o-t' class='color t'>Future Value</td>" + row_E
            }
        }
        
        
        else{
            cell.Years.layer.borderWidth = 1
            cell.Future_Value.layer.borderWidth = 1
            cell.Invested.layer.borderWidth = 1
            cell.Years.text = String(Int(years[indexPath.row]))
            cell.layer.borderWidth = 1
            if indexPath.row == 20
            {
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            }
            let year = years[indexPath.row]
            if fromScreen == "SIP"
            {
                let TotalInvestedAmount = MonthlyAmount * 12 * Double(years[indexPath.row])
                
                let rate = Double(RateOfReturn/1200)
                //                var total = MonthlyAmount * ((pow(1 + rate, 12 * year[indexPath.row] ) - 1) / rate) * (1 + rate)
                let power : Double = pow(1 + rate, 12 * years[indexPath.row] ) - 1
                let divideByRate : Double = power / rate
                let all_Mul : Double = MonthlyAmount * divideByRate * (1 + rate)
                let roundOfValue = round(all_Mul * 1) / 1
                
                cell.Invested.text = change(num: TotalInvestedAmount)
                cell.Future_Value.text = formate(num: roundOfValue)
                
                if indexPath.row != 20
                {
                    html += row_S + "<td class='t'>\(Int(years[indexPath.row]))</td><td class='t'>\(change(num: TotalInvestedAmount))</td><td class='t'>\(formate(num: roundOfValue))</td>" + row_E
                }
                else
                {
                    html += row_S + "<td id = 's-o' class='t'>\(Int(years[indexPath.row]))</td><td class='t'>\(change(num: TotalInvestedAmount))</td><td id = 's-t' class='t'>\(formate(num: roundOfValue))</td>" + row_E + table2_E + "</body>"
                    print(html)
                }
                
                
            }
            if fromScreen == "Lumpsum"
            {
                
                let interest = TotalAmount * pow((1.0 + (RateOfReturn/100)),Double(year))
                cell.Invested.text = change(num: TotalAmount)
                cell.Future_Value.text = formate(num: interest)
                if indexPath.row != 20
                {
                    html += row_S + "<td class='t'>\(Int(years[indexPath.row]))</td><td class='t'>\(change(num: TotalAmount))</td><td class='t'>\(formate(num: interest))</td>" + row_E
                }
                else{
                    html += row_S + "<td id = 's-o' class='t'>\(Int(years[indexPath.row]))</td><td class='t'>\(change(num: TotalAmount))</td><td id = 's-t' class='t'>\(formate(num: interest))</td>" + row_E + table2_E + "</body>"
                }
            }
            if fromScreen == "SIP_Planner"
            {
                
                _ = MonthlyAmount * 12 * Double(years[indexPath.row])
                
                cell.Invested.text = change(num: MonthlyAmount)
                let rate = Double(RateOfReturn/1200)
                
                let power : Double = pow(1 + rate, 12 * years[indexPath.row] ) - 1
                let divideByRate : Double = power / rate
                let all_Mul : Double = MonthlyAmount * divideByRate * (1 + rate)
                let roundOfValue = round(all_Mul * 10000) / 10000
                cell.Future_Value.text = formate(num: roundOfValue)
                
                if indexPath.row != 20
                {
                    html += row_S + "<td class='t'>\(Int(years[indexPath.row]))</td><td class='t'>\(change(num: MonthlyAmount))</td><td class='t'>\(formate(num: roundOfValue))</td>" + row_E
                }
                else
                {
                    html += row_S + "<td id = 's-o' class='t'>\(Int(years[indexPath.row]))</td><td class='t'>\(change(num: MonthlyAmount))</td><td id = 's-t' class='t'>\(formate(num: roundOfValue))</td>" + row_E + table2_E + "</body>"
                    
                    print(html)
                }
                
            }
        }
        return cell
    }
    
    
    @IBAction func Open_html(_ sender: UIBarButtonItem) {
        self.convertToPdfFileAndShare()
    }
    
    
    func convertToPdfFileAndShare(){
        
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Result").appendingPathExtension("pdf")
        else { fatalError("Destination URL not created") }
        
        pdfData.write(to: outputURL, atomically: true)
        print("open \(outputURL.path)")
        
        if FileManager.default.fileExists(atPath: outputURL.path){
            
            let url = URL(fileURLWithPath: outputURL.path)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            
            //If user on iPad
            if UIDevice.current.userInterfaceIdiom == .pad {
                if activityViewController.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                }
            }
            present(activityViewController, animated: true, completion: nil)
            
        }
        else {
            print("document was not found")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard (textField.text?.count ?? 0)>0 else{ return }
        html = textField.text ?? ""
    }
    
}
