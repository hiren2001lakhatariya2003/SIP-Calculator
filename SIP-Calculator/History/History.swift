//
//  History.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 19/03/23.
//

import UIKit

class History: NSObject {
    var cal_id : Int32 = Int32()
    var rate: Double = Double();
    var toolId : Int32 = Int32()
    var toolName : String = String();
    // SIP-INPUT
    var SIP_MonthlyAmount : Double = Double();
    var SIP_RateOfReturn :  Double = Double();
    var SIP_Year : Double = Double();
    // SIP-OUTPUT
    var SIP_TotalInvestAmount : Double = Double();
    var SIP_ExpectedReturn : Double = Double();
    var SIP_TotalValue : Double = Double();
    var SIP_Date : String = String()
    //LUMPSUM-INPUT
    var Lumpsum_TotalInvestment : Double = Double()
    var Lumpsum_RateOfReturn : Double = Double()
    var Lumpsum_Year : Double = Double()
    // LUMPSUM - OUTPUT
    var Lumpsum_InvestedAmount : Double = Double()
    var Lumpsum_ExpectedReturn : Double = Double()
    var Lumpsum_TotalValue : Double = Double()
    var Lumpsum_Date : String = String()
    // SWP-INPUT
    var SWP_TotalInvestment : Double = Double()
    var SWP_WithdrawalAmount : Double = Double()
    var SWP_RateOfReturn : Double = Double()
    var SWP_Year : Double = Double()
    // SWP-OUTPUT
    var SWP_TotalWithdrawals : Double = Double()
    var SWP_ExpectedReturn : Double = Double()
    var SWP_FinalBalance : Double = Double()
    var SWP_Count : Int = Int()
    var SWP_Date : String = String()
    // SIPP-INPUT
    var SIPP_ExpectedAmount : Double  = Double()
    var SIPP_Year : Double  = Double()
    var SIPP_RateOfReturn : Double  = Double()
    // SIPP-OUTPUT
    var SIPP_EstimatedReturn : Double  = Double()
    var SIPP_MonthlyAmount : Double  = Double()
    var SIPP_InvestedAmount : Double  = Double()
    var SIPP_Date : String = String()
    var SIPP_Inflaction : Double = Double()
}
