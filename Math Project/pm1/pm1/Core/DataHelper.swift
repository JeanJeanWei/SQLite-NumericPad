//
//  DataHelper.swift
//  pm1
//
//  Created by Jean-Jean Wei on 2016-12-05.
//  Copyright © 2016 Jean-Jean Wei. All rights reserved.
//

import Foundation
import SQLite


protocol DataHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(item: T) throws -> Int64
    static func delete(item: T) throws -> Void
    static func findAll() throws -> [T]?
}

class ExamDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "ExamRecords"
    
    static let examId = Expression<Int64>("examid")
    static let firstName = Expression<String>("firstName")
    static let lastName = Expression<String>("lastName")
    static let score = Expression<Int>("score")
    static let duration = Expression<Int64>("duration")
    static let totalQuestions = Expression<Int>("totalQuestions")
    static let level = Expression<String>("level")
    
    static let table = Table(TABLE_NAME)
    
    typealias T = Exam
    
    static func createTable() throws {
        guard let DB = DBManager.instance.db else {
            throw  DBManager.DataAccessError.Datastore_Connection_Error
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                
                t.column(examId, primaryKey: true)
                t.column(firstName)
                t.column(lastName)
                t.column(score)
                t.column(duration)
                t.column(totalQuestions)
                t.column(level)
            })
        } catch _ {
            // Error thrown when table exists
        }
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = DBManager.instance.db else {
            throw DBManager.DataAccessError.Datastore_Connection_Error
        }
        if (item.firstName != nil && item.score != nil && item.duration != nil)
        {
            let insert = table.insert(firstName <- item.firstName!, score <- item.score!, lastName <- item.lastName!, duration <- item.duration!, level <- item.level!.rawValue)
            do {
                let rowId = try DB.run(insert)
                guard rowId >= 0 else {
                    throw DBManager.DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DBManager.DataAccessError.Insert_Error
            }
        }
        throw DBManager.DataAccessError.Nil_In_Data
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = DBManager.instance.db else {
            throw DBManager.DataAccessError.Datastore_Connection_Error
        }
        if let id = item.examId {
            let query = table.filter(examId == id)
            do {
                let tmp = try DB.run(query.delete())
                guard tmp == 1 else {
                    throw DBManager.DataAccessError.Delete_Error
                }
            } catch _ {
                throw DBManager.DataAccessError.Delete_Error
            }
        }
        
    }
    
    static func find(id: Int64) throws -> T? {
        guard let DB = DBManager.instance.db else {
            throw DBManager.DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(examId == id)
        let items = try DB.prepare(query)
        for item in  items {
            return Exam(examId: item[examId], firstName: item[firstName], lastName: item[lastName], score: item[score], duration: item[duration], totalQuestions: item[totalQuestions], level: Levels(rawValue: item[level]))
        }
        
        return nil
        
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = DBManager.instance.db else {
            throw DBManager.DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(Exam(examId: item[examId], firstName: item[firstName], lastName: item[lastName], score: item[score], duration: item[duration], totalQuestions: item[totalQuestions], level: Levels(rawValue: item[level])))
        }
        
        return retArray
    }
}
