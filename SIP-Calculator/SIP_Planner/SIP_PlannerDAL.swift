//
//  SIP_Planner.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 08/04/23.
//

import UIKit

class SIP_Planner: NSObject {
    class func Add_Cal (h:History)-> Bool
    {
        var Status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "insert into All_CAL (SIPP_ExpectedAmount,SIPP_Year,SIPP_RateOfReturn,SIPP_EstimatedReturn,SIPP_MonthlyAmount,SIPP_InvestedAmount,SIPP_Date,Tool_id,SIPP_Inflaction) values ('\(h.SIPP_ExpectedAmount)','\(h.SIPP_Year)','\(h.SIPP_RateOfReturn)','\(h.SIPP_EstimatedReturn)','\(h.SIPP_MonthlyAmount)','\(h.SIPP_InvestedAmount)','\(h.SIPP_Date)',4,'\(h.SIPP_Inflaction)')"
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
