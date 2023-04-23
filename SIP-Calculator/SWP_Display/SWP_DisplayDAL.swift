//
//  SWP_DisplayDal.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 29/03/23.
//

import UIKit

class SWP_DisplayDal: NSObject {
    class func Add_Cal (h:History)-> Bool
    {
        
        var Status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "insert into All_CAL (SWP_TotalInvestment,SWP_WithdrawalAmount,SWP_RateOfReturn,SWP_Year,SWP_FinalBalance,SWP_TotalWithdrawals,SWP_EstimatedReturn,SWP_Count,SWP_Date,Tool_id) values ('\(h.SWP_TotalInvestment)','\(h.SWP_WithdrawalAmount)','\(h.SWP_RateOfReturn)','\(h.SWP_Year)','\(h.SWP_FinalBalance)','\(h.SWP_TotalWithdrawals)','\(h.SWP_ExpectedReturn)','\(h.SWP_Count)','\(h.SWP_Date)',2)"
            do
            {
                let resultset = dbConn.executeUpdate(query, withArgumentsIn: [])
                if resultset
                {
                    Status = true
                }
                else
                {
                    Status = false
                }
            }
            
        }
        else
        {
            print("Database not Connected")
        }
        return Status
    }
}
