//
//  ToolsDAL.swift
//  SIP_Calculator
//
//  Created by Hiren Lakhatariya on 22/03/23.
//

import UIKit

class ToolsDAL: NSObject {
    
    class func get_Tools()->[Tools]
    {
        var tools: [Tools] = []
        
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "select * from Tools"
            do{
                let resultSet = try dbConn.executeQuery(query, values: [])
                
                while(resultSet.next())
                {
                    let t : Tools = Tools();
                    t.ToolName = resultSet.string(forColumn: "ToolName")!
                    t.ToolImage = resultSet.string(forColumn: "ToolName")! + ".png"
                    tools.append(t)
                    
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
        return tools;
    }
    
    class func delete_Cal (h:History)-> Bool
    {
        var Status : Bool = Bool()
        let dbConn = FMDatabase(path: Utility.getPath(Utility.dbName))
        
        if dbConn.open()
        {
            let query = "delete from SIP where cal_id = '\(h.cal_id)'"
            do
            {
                let resultset =  dbConn.executeUpdate(query, withArgumentsIn: [])
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
