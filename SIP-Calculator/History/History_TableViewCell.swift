//
//  History_TableViewCell.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 18/03/23.
//

import UIKit
import Charts

class History_TableViewCell: UITableViewCell {
    // SIP
    @IBOutlet weak var Monthly_Amount: UILabel!
    @IBOutlet weak var Expected_Return: UILabel!
    @IBOutlet weak var Tenure: UILabel!
    //    @IBOutlet weak var Estimated_Return: UILabel!
    @IBOutlet weak var Total_Value: UILabel!
    @IBOutlet weak var Invested_Amount: UILabel!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var delete_SIP_multiple: UIButton!
    
    
    @IBOutlet weak var Display_History_view: UIView!
    @IBOutlet weak var SIP_Date: UILabel!
    // Lumpsum
    @IBOutlet weak var LTitle: UILabel!
    @IBOutlet weak var LInvested_Amount: UILabel!
    @IBOutlet weak var LExpected_Return: UILabel!
    @IBOutlet weak var LTenure: UILabel!
    //    @IBOutlet weak var LEstimated_Return: UILabel!
    @IBOutlet weak var LTotal_Value: UILabel!
    @IBOutlet weak var Lumpsum_View: UIView!
    @IBOutlet weak var SIP_View: UIView!
    @IBOutlet weak var LTotal_Investment: UILabel!
    
    @IBOutlet weak var Lumpsum_delete: UIButton!
    @IBOutlet weak var Lumpsum_Date: UILabel!
    // SWP
    @IBOutlet weak var SWP_View: UIView!
    @IBOutlet weak var Total_Investment: UILabel!
    @IBOutlet weak var Withdrawal_Amount: UILabel!
    @IBOutlet weak var SWP_Expected_return: UILabel!
    @IBOutlet weak var SWP_Tenure: UILabel!
    //    @IBOutlet weak var SWP_Estimated_Return: UILabel!
    @IBOutlet weak var Total_Withdrawal: UILabel!
    @IBOutlet weak var Final_Balance: UILabel!
    @IBOutlet weak var SWP_Delete: UIButton!
    @IBOutlet weak var SWP_Date: UILabel!
    // SIP_Planner
    @IBOutlet weak var SIPP_Expected_Amount: UILabel!
    @IBOutlet weak var SIPP_Tenure: UILabel!
    @IBOutlet weak var SIPP_Rate_Of_Return: UILabel!
    //    @IBOutlet weak var SIPP_Estimated_Return: UILabel!
    @IBOutlet weak var SIPP_Monthly_Amount: UILabel!
    @IBOutlet weak var SIPP_Invested_Amount: UILabel!
    @IBOutlet weak var SIPP_Delete: UIButton!
    
    @IBOutlet weak var SIPP_View: UIView!
    @IBOutlet weak var SIP_PLANNER_DATE: UILabel!
    @IBOutlet weak var SIPP_Inflaction: UILabel!
    
    @IBOutlet weak var Delete_SIP: UIButton!
    @IBOutlet weak var Delete_SWP: UIButton!
    @IBOutlet weak var Delete_SIPP: UIButton!
    @IBOutlet weak var Delete_Lumpsum: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBAction func delete_row(_ sender: Any) {
        
    }
}
