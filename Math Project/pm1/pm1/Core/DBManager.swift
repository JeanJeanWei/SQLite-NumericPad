//
//  DBManager.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-12-02.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//

import Foundation
import SQLite



class DBManager
{
    enum DataAccessError: Error
    {
        case Datastore_Connection_Error
        case Insert_Error
        case Delete_Error
        case Search_Error
        case Nil_In_Data
    }
    
    static let instance = DBManager()
    let db: Connection?
    let dbFilename = "db.sqlite3"
    
    //This prevents others from using the default '()' initializer for this class.
    private init()
    {
        let dir = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        let path = dir.appending(dbFilename)
        do
        {
            db = try Connection(path)
        }
        catch _
        {
            db = nil
        }
    }
    
    func createTables() throws{
        do
        {
            //try TeamDataHelper.createTable()
            try ExamDataHelper.createTable()
        }
        catch
        {
            throw DataAccessError.Datastore_Connection_Error
        }
    }

}
