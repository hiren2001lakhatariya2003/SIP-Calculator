//
//  Lumpsum_DisplayDAL.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 24/03/23.
//

import UIKit

class Lumpsum_DisplayDAL: NSObject {
    class func Add_Cal (h:History)-> Bool
    {
        
        var Status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "insert into All_CAL (Lumpsum_TotalInvestment,Lumpsum_RateOfReturn,Lumpsum_Year,Lumpsum_InvestedAmount,Lumpsum_ExpectedReturn,Lumpsum_TotalValue,Lumpsum_Date,Tool_id) values ('\(h.Lumpsum_TotalInvestment)','\(h.Lumpsum_RateOfReturn)','\(h.Lumpsum_Year)','\(h.Lumpsum_InvestedAmount)','\(h.Lumpsum_ExpectedReturn)','\(h.Lumpsum_TotalValue)','\(h.Lumpsum_Date)',3)"
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
