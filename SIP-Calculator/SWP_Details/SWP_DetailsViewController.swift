//
//  SWP_DetailsViewController.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 28/03/23.
//

import UIKit

class SWP_DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var month : [Int] = [];
    
    
    @IBOutlet weak var Total_Investment: UILabel!
    @IBOutlet weak var Expected_return: UILabel!
    @IBOutlet weak var Tenure: UILabel!
    @IBOutlet weak var withdrawal_amount: UILabel!
    @IBOutlet weak var Final_Balance: UILabel!
    @IBOutlet weak var Total_withdrawal: UILabel!
    @IBOutlet weak var Vertical_stack: UIStackView!
    @IBOutlet weak var table_view_Height: NSLayoutConstraint!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var main_view_height: NSLayoutConstraint!
    
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
    
    var totalInvestedAmount : Double = Double()
    var withdrawalAmount : Double = Double()
    var RateOfReturn : Double = Double()
    var Year : Double = Double()
    var FinalBalance : Double = Double()
    var EstimatedReturn : Double = Double()
    var Display_TotalInvested : Double = Double()
    var totalWithdrawal : Double = Double()
    var cell_count : Int32 = Int32()
    let margin_left : CGFloat = CGFloat(8)
    let margin_right : CGFloat = CGFloat(0)
    let margin_top : CGFloat = CGFloat(0)
    let margin_bottom : CGFloat = CGFloat(0)
    var year_cell : Int = Int()
    var Count : Int = Int()
    var FinalEstimatedReturn = 0.0
    var saveEstimatedResult = 0.0
    var TOTALWITHDRAWAL = 0.0
    var rest_amount_for_last_row : Double = Double()
    var stringFormate : String = String()
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
        EstimatedReturn = 0.0
        year_cell = Int(Year) * 12
        cell_count = 0
        main_view_height.constant -= 50
        
        html = "<!DOCTYPE html> <html> <head> <title>Table with Rounded Corners</title> <style> body {font-family: sans-serif; } h1 {color: rgb(160, 113, 116); text-align: center; } h4{text-align: center; } #table1 {border: 1px solid black; text-align: left; border-radius: 10px; width: 350px; } #table2 {border: 1px solid black; border-radius: 10px; width: 700px; } td {border: 1px solid black; text-align: left; padding: 5px; } .o {width: 50%; height: 5px; } .t {width: 25%; text-align: center; } #o-o {border-radius: 8px 0 0 0; } #o-t {border-radius:0 8px 0 0; } #s-o {border-radius: 0 0 0 8px; } #s-t {border-radius:0 0 8px 0; } .color {background-color: rgb(190, 169, 160); } </style> </head> <body> <h1> SWP Details </h1>"
        
        table1_S = "<table cellspacing='0' align='center' id = 'table1'>"
        table1_E = "</table>"
        table2_S = "<table cellspacing='0' align='center' id = 'table2'>"
        table2_E = "</table>"
        
        head_S = "<th>"
        head_E = "</th>"
        
        row_S = "<tr>"
        row_E = "</tr>"
        
        newLine = "<br>"
        
        
        for i in 0..<year_cell+1
        {
            month.append(i)
            print(month[i])
        }
        print(Count)
        
        self.title = "Details"
        
        Total_Investment.text = change(num: totalInvestedAmount)
        withdrawal_amount.text = change(num: withdrawalAmount)
        Expected_return.text  = String(RateOfReturn) + " %"
        Tenure.text = String(Int(Year)) + " Years"
        Final_Balance.text = change(num: FinalBalance)
        Total_withdrawal.text = change(num: totalWithdrawal)
        
        html += table1_S + row_S + "<td id = 'o-o' class='o'>Total Investment</td><td  id = 'o-t'>\(change(num: totalInvestedAmount))</td>" + row_E
        html += row_S + "<td class='o'>Withdrawal Amount</td><td class='o'>\(change(num: withdrawalAmount))</td>" + row_E
        html += row_S + "<td class='o'>Exp. Return Rate(%)</td><td class='o'>\(RateOfReturn) %</td>" + row_E
        html += row_S + "<td class='o'>Tenure(Year)</td><td class='o'>\(Int(Year)) Years</td>" + row_E
        html += row_S + "<td class='o'>Final Balance</td><td class='o'>\(change(num: FinalBalance))</td>" + row_E
        html += row_S + "<td  id = 's-o' class='o'>Total Withrawal </td><td id = 's-t' class='o'>\(change(num: totalWithdrawal))</td>" + row_E + table1_E + newLine + table2_S
        
        Vertical_stack.layer.cornerRadius = 10
        Vertical_stack.layer.borderWidth = 1
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
        
        
    }
    
    override func viewWillLayoutSubviews() {
        self.table_view_Height.constant = self.table_view.contentSize.height
    }
    
    func decrease_Table_hight(){
        self.table_view.frame.size.height -= 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return month.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "swp_details", for: indexPath) as! SWP_DetailsTableViewCell
        
        if (indexPath.row == 0)
        {
            html += row_S + "<td id = 'o-o' class='color t'>Month</td><td class='color t'>Withdrawal Amount</td><td class='color t'>Return</td><td id = 'o-t' class='color t'>Month End Balance</td>" + row_E
            
            cell.Month.text = "Month"
            cell.Withdrawal_Amount.text = "Withdrawal Amount"
            cell.Returns.text = "Return"
            cell.Month_End.text = "Month End Balance"
            cell.backgroundColor = UIColor(red: (190/255), green: (169/255), blue: (160/255), alpha: 1)
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            cell.Month.layer.cornerRadius = 10
            cell.Month.layer.maskedCorners = [.layerMinXMinYCorner]
            cell.Month_End.layer.cornerRadius = 10
            cell.Month_End.layer.maskedCorners = [.layerMaxXMinYCorner]
            
            cell.Month.layer.borderWidth = 1
            cell.Month_End.layer.borderWidth = 1
            cell.Returns.layer.borderWidth = 1
            cell.Withdrawal_Amount.layer.borderWidth = 1
            
        }
        else{
            cell.Month.layer.borderWidth = 1
            cell.Month_End.layer.borderWidth = 1
            cell.Returns.layer.borderWidth = 1
            cell.Withdrawal_Amount.layer.borderWidth = 1
            let restAmount = totalInvestedAmount - withdrawalAmount
            
            let returns = round(restAmount * ( RateOfReturn / 1200) * 100) / 100
            
            TOTALWITHDRAWAL = TOTALWITHDRAWAL + withdrawalAmount
            
            EstimatedReturn = EstimatedReturn +  returns
            cell_count = cell_count + 1
            
            if((indexPath.row ) % 12 != 0 && cell_count <= Count)
            {
                totalInvestedAmount = restAmount
                
                saveEstimatedResult = saveEstimatedResult + returns
                if(totalInvestedAmount <= withdrawalAmount)
                {   TOTALWITHDRAWAL = TOTALWITHDRAWAL + totalInvestedAmount
                    print(TOTALWITHDRAWAL)
                    totalInvestedAmount = 0
                }
                main_view_height.constant += 44
                
                print(returns,"----",restAmount,"----",saveEstimatedResult)
                
                cell.Withdrawal_Amount.text = change(num: withdrawalAmount)
                cell.Month.text = String(indexPath.row)
                cell.Month_End.text = formate(num: restAmount)
                cell.Returns.text = change(num: returns)
                html += row_S + "<td class='t'>\(Int(indexPath.row))</td><td class='t'>\(change(num: withdrawalAmount))</td><td class='t'>\(change(num: returns))</td><td class='t'>\(formate(num: restAmount))</td>" + row_E
                rest_amount_for_last_row = Double(round(restAmount * 100) /  100)
            }
            
            else if( indexPath.row == year_cell+1 &&  cell_count <= Count)
            {
                totalInvestedAmount = restAmount + FinalEstimatedReturn + EstimatedReturn
                
                saveEstimatedResult = saveEstimatedResult + returns
                if(totalInvestedAmount <= withdrawalAmount)
                {
                    print(TOTALWITHDRAWAL)
                }
                
                print(returns,"----",totalInvestedAmount,"----",saveEstimatedResult)
            }
            
            else if ( cell_count <= Count)
            {
                totalInvestedAmount = restAmount + EstimatedReturn
                
                print(returns,"----",totalInvestedAmount)
                saveEstimatedResult = saveEstimatedResult + returns
                rest_amount_for_last_row = totalInvestedAmount
                EstimatedReturn = 0.0
                FinalEstimatedReturn = EstimatedReturn
                
                if(totalInvestedAmount <= withdrawalAmount)
                {
                    print(TOTALWITHDRAWAL)
                }
                if(cell_count == Count)
                {
                    cell.Month.layer.cornerRadius = 10
                    cell.Month.layer.maskedCorners = [.layerMinXMaxYCorner]
                    cell.Month_End.layer.cornerRadius = 10
                    cell.Month_End.layer.maskedCorners = [.layerMaxXMaxYCorner]
                }
                main_view_height.constant += 44
                cell.Month_End.text = formate(num: totalInvestedAmount)
                cell.Returns.text = change(num: returns)
                cell.Month.text = String(Int(indexPath.row))
                cell.Withdrawal_Amount.text = change(num: withdrawalAmount)
                
                html += row_S + "<td id = 's-o' class='t'>\(Int(indexPath.row))</td><td class='t'>\(change(num: withdrawalAmount))</td><td class='t'>\(change(num: returns))</td><td id = 's-t' class='t'>\(formate(num: totalInvestedAmount))</td>" + row_E
                print(html)
                
            }
            else if(indexPath.row == Count + 1) {
                
                if(restAmount < withdrawalAmount){
                    cell.Withdrawal_Amount.text = String(Int(rest_amount_for_last_row))
                    cell.Month.text = String(indexPath.row)
                    cell.Returns.text = "0"
                    cell.Month_End.text = "0"
                    main_view_height.constant += 44
                    cell.Month.layer.cornerRadius = 10
                    cell.Month.layer.maskedCorners = [.layerMinXMaxYCorner]
                    cell.Month_End.layer.cornerRadius = 10
                    cell.Month_End.layer.maskedCorners = [.layerMaxXMaxYCorner]
                    html += row_S + "<td id = 's-o' class='t'>\(Int(indexPath.row))</td><td class='t'>\(change(num: rest_amount_for_last_row))</td><td class='t'>0</td><td id = 's-t' class='t'>0</td>" + row_E + table2_E + "</body>"
                    print(html)
                }
                else
                {
                    
                    totalInvestedAmount = restAmount + EstimatedReturn
                    cell.Withdrawal_Amount.text = change(num:withdrawalAmount)
                    cell.Month.text = String(indexPath.row)
                    
                    cell.Returns.text = change(num: returns)
                    main_view_height.constant += 44
                    cell.Month_End.text = formate(num: totalInvestedAmount)
                    cell.Month.layer.cornerRadius = 10
                    cell.Month.layer.maskedCorners = [.layerMinXMaxYCorner]
                    cell.Month_End.layer.cornerRadius = 10
                    cell.Month_End.layer.maskedCorners = [.layerMaxXMaxYCorner]
                    html += row_S + "<td id = 's-o' class='t'>\(Int(indexPath.row))</td><td class='color t'>\(change(num: withdrawalAmount))</td><td class='t'>\(change(num: returns))</td><td id = 's-t' class='color t'>\(formate(num: totalInvestedAmount))</td>" + row_E + table2_E + "</body>"
                    print(html)
                }
                
            }
            else
            {
                cell.isHidden = true
                
            }
        }
        return cell;
    }
    
    
    @IBAction func Share_Pdf(_ sender: UIBarButtonItem) {
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
