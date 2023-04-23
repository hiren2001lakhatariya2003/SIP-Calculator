//
//  SIP_DisplayDAL.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 19/03/23.
//

import UIKit

class SIP_DisplayDAL: NSObject {
    class func Add_Cal (h:History)-> Bool
    {
        
        var Status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "insert into All_CAL (SIP_MonthlyAmount,SIP_RateOfReturn,SIP_Year,SIP_ExpectedReturn,SIP_TotalValue,SIP_TotalInvestAmount,SIP_Date,Tool_id) values ('\(h.SIP_MonthlyAmount)','\(h.SIP_RateOfReturn)','\(h.SIP_Year)','\(h.SIP_ExpectedReturn)','\(h.SIP_TotalValue)','\(h.SIP_TotalInvestAmount)','\(h.SIP_Date)',1)"
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
