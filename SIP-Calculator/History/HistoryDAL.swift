//
//  HistoryDAL.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 19/03/23.
//

import UIKit

class HistoryDAL: NSObject {
    
    
    
    class func get_History()->[History]
    {
        var history: [History] = []
        
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "select * from All_CAL inner join Tools on All_CAL.Tool_id = Tools.Toolid "
            do{
                let resultSet = try dbConn.executeQuery(query, values: [])
                
                while(resultSet.next())
                {
                    let h: History = History()
                    h.toolId = resultSet.int(forColumn: "Tool_id")
                    h.cal_id =  resultSet.int(forColumn: "cal_id")
                    h.toolName = resultSet.string(forColumn: "ToolName") ?? ""
                    // SIP
                    h.SIP_MonthlyAmount = resultSet.double(forColumn: "SIP_MonthlyAmount")
                    h.SIP_RateOfReturn = resultSet.double(forColumn: "SIP_RateOfReturn")
                    h.SIP_Year = resultSet.double(forColumn: "SIP_Year")
                    h.SIP_ExpectedReturn = resultSet.double(forColumn: "SIP_ExpectedReturn")
                    h.SIP_TotalValue = resultSet.double(forColumn: "SIP_TotalValue")
                    h.SIP_TotalInvestAmount = resultSet.double(forColumn: "SIP_TotalInvestAmount")
                    h.SIP_Date = resultSet.string(forColumn: "SIP_Date") ?? ""
                    
                    // LUMPSUM
                    h.Lumpsum_TotalInvestment = resultSet.double(forColumn: "Lumpsum_TotalInvestment")
                    h.Lumpsum_RateOfReturn = resultSet.double(forColumn: "Lumpsum_RateOfReturn")
                    h.Lumpsum_Year = resultSet.double(forColumn: "Lumpsum_Year")
                    h.Lumpsum_InvestedAmount = resultSet.double(forColumn: "Lumpsum_InvestedAmount")
                    h.Lumpsum_ExpectedReturn = resultSet.double(forColumn: "Lumpsum_ExpectedReturn")
                    h.Lumpsum_TotalValue = resultSet.double(forColumn: "Lumpsum_TotalValue")
                    h.Lumpsum_Date = resultSet.string(forColumn: "Lumpsum_Date") ?? ""
                    
                    // SWP
                    h.SWP_TotalInvestment = resultSet.double(forColumn: "SWP_TotalInvestment")
                    h.SWP_WithdrawalAmount = resultSet.double(forColumn: "SWP_WithdrawalAmount")
                    h.SWP_RateOfReturn = resultSet.double(forColumn: "SWP_RateOfReturn")
                    h.SWP_Year = resultSet.double(forColumn: "SWP_Year")
                    h.SWP_FinalBalance = resultSet.double(forColumn: "SWP_FinalBalance")
                    h.SWP_TotalWithdrawals = resultSet.double(forColumn: "SWP_TotalWithdrawals")
                    h.SWP_ExpectedReturn = resultSet.double(forColumn: "SWP_EstimatedReturn")
                    h.SWP_Count = Int(resultSet.int(forColumn: "SWP_Count"))
                    h.SWP_Date = resultSet.string(forColumn: "SWP_Date") ?? ""
                    
                    // SIP-Planner
                    h.SIPP_ExpectedAmount = resultSet.double(forColumn: "SIPP_ExpectedAmount")
                    h.SIPP_RateOfReturn = resultSet.double(forColumn: "SIPP_RateOfReturn")
                    h.SIPP_Year = resultSet.double(forColumn: "SIPP_Year")
                    h.SIPP_EstimatedReturn = resultSet.double(forColumn: "SIPP_EstimatedReturn")
                    h.SIPP_MonthlyAmount = resultSet.double(forColumn: "SIPP_MonthlyAmount")
                    h.SIPP_InvestedAmount = resultSet.double(forColumn: "SIPP_InvestedAmount")
                    h.SIPP_Date = resultSet.string(forColumn: "SIPP_Date") ?? ""
                    h.SIPP_Inflaction = resultSet.double(forColumn: "SIPP_Inflaction")
                    history.append(h)
                }
            }
            catch
            {
                print(error)
            }
        }
        else
        {
            print("not Connected with Database")
        }
        
        dbConn.close()
        return history;
    }
    
    class func delete_Cal (h:History)-> Bool
    {
        var Status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "delete from All_CAL where cal_id = '\(h.cal_id)'"
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
    
    class func delete_all ()-> Bool
    {
        var Status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "delete from All_CAL"
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
