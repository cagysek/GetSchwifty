//
//  DatabaseService+functions.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 09.07.2022.
//

import Foundation
import SQLite3

extension DatabaseService {
    func create(characterId: Int) {
            // ensure statements are created on first usage if nil
            guard self.prepareInsertEntryStmt() == SQLITE_OK else { return }
            
            defer {
                // reset the prepared statement on exit.
                sqlite3_reset(self.insertEntryStmt)
            }
            
            //  At some places (esp sqlite3_bind_xxx functions), we typecast String to NSString and then convert to char*,
            // ex: (eventLog as NSString).utf8String. This is a weird bug in swift's sqlite3 bridging. this conversion resolves it.
            
            //Inserting name in insertEntryStmt prepared statement
            if sqlite3_bind_int(self.insertEntryStmt, 1, Int32(characterId)) != SQLITE_OK {
                logDbErr("sqlite3_bind_text(insertEntryStmt)")
                return
            }
            
           
            
            //executing the query to insert values
            let r = sqlite3_step(self.insertEntryStmt)
            if r != SQLITE_DONE {
                logDbErr("sqlite3_step(insertEntryStmt) \(r)")
                return
            }
        }
        
        //"SELECT * FROM Records WHERE EmployeeID = ? LIMIT 1"
    func read(characterIds: [Int]) throws -> [Int: Int] {
            // ensure statements are created on first usage if nil
            guard self.prepareReadEntryStmt(parametersCount: characterIds.count) == SQLITE_OK else { throw SqliteError(message: "Error in prepareReadEntryStmt") }

            defer {
                // reset the prepared statement on exit.
                sqlite3_reset(self.readEntryStmt)
            }

            //  At some places (esp sqlite3_bind_xxx functions), we typecast String to NSString and then convert to char*,
            // ex: (eventLog as NSString).utf8String. This is a weird bug in swift's sqlite3 bridging. this conversion resolves it.

            //Inserting employeeID in readEntryStmt prepared statement
            
            var parameterIndex = 1
            for characterId in characterIds {
                if sqlite3_bind_int(self.readEntryStmt, Int32(parameterIndex), Int32(characterId)) != SQLITE_OK {
                    logDbErr("sqlite3_bind_text(readEntryStmt)")
                    throw SqliteError(message: "Error in inserting value in prepareReadEntryStmt")
                }
                
                parameterIndex += 1
            }
            
            var result = [Int: Int]()
            
            while (sqlite3_step(readEntryStmt) == SQLITE_ROW) {
                let characterId = sqlite3_column_int(readEntryStmt, 1)
                
                result[Int(characterId)] = 1

            }

            return result
        }
        
        
        //"DELETE FROM Records WHERE EmployeeID = ?"
        func delete(characterId: Int) {
            // ensure statements are created on first usage if nil
            guard self.prepareDeleteEntryStmt() == SQLITE_OK else { return }
            
            defer {
                // reset the prepared statement on exit.
                sqlite3_reset(self.deleteEntryStmt)
            }
            
            //  At some places (esp sqlite3_bind_xxx functions), we typecast String to NSString and then convert to char*,
            // ex: (eventLog as NSString).utf8String. This is a weird bug in swift's sqlite3 bridging. this conversion resolves it.
            
            //Inserting name in deleteEntryStmt prepared statement
            if sqlite3_bind_int(self.deleteEntryStmt, 1, Int32(characterId)) != SQLITE_OK {
                logDbErr("sqlite3_bind_text(deleteEntryStmt)")
                return
            }
            
            //executing the query to delete row
            let r = sqlite3_step(self.deleteEntryStmt)
            if r != SQLITE_DONE {
                logDbErr("sqlite3_step(deleteEntryStmt) \(r)")
                return
            }
        }
        
        // INSERT/CREATE operation prepared statement
        func prepareInsertEntryStmt() -> Int32 {
            guard insertEntryStmt == nil else { return SQLITE_OK }
            let sql = "INSERT INTO Favorites (character_id) VALUES (?)"
            //preparing the query
            let r = sqlite3_prepare(db, sql, -1, &insertEntryStmt, nil)
            if  r != SQLITE_OK {
                logDbErr("sqlite3_prepare insertEntryStmt")
            }
            return r
        }
        
        // READ operation prepared statement
        func prepareReadEntryStmt(parametersCount: Int) -> Int32 {
//            guard readEntryStmt == nil else { return SQLITE_OK }
            
            var sql = "SELECT * FROM Favorites WHERE character_id IN ("
            
            for i in 0 ..< parametersCount {
                if (i == 0) {
                    sql.append(contentsOf: "?")
                    continue
                }
                
                sql.append(contentsOf: ",?")
            }
            
            sql.append(contentsOf: ")")
            
            
            //preparing the query
            let r = sqlite3_prepare(db, sql, -1, &readEntryStmt, nil)
            if  r != SQLITE_OK {
                logDbErr("sqlite3_prepare readEntryStmt")
            }
            return r
        }
        
        
        // DELETE operation prepared statement
        func prepareDeleteEntryStmt() -> Int32 {
            guard deleteEntryStmt == nil else { return SQLITE_OK }
            let sql = "DELETE FROM Favorites WHERE character_id = ?"
            //preparing the query
            let r = sqlite3_prepare(db, sql, -1, &deleteEntryStmt, nil)
            if  r != SQLITE_OK {
                logDbErr("sqlite3_prepare deleteEntryStmt")
            }
            return r
        }
}
