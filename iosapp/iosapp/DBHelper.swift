//
//  DBHelper.swift
//  iosapp
//
//  Created by Dwicky Fauza on 11/28/19.
//  Copyright © 2019 IOSLOSS. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {
    init() {
        db = openDatabase()
        createTable()
        createTableAdmin()
    }
    
    let dbPath: String = "furnitureDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db : OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else{
            print("Succusessfully opened connection to database at \(dbPath)")
            return db
        }
        
    }
    //furniture
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS furniture (id INTEGER PRIMARY KEY,nama TEXT,kategori TEXT,stok INT,harga DOUBLE);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("furniture table created.")
            } else {
                print("furniture table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    //login
    func createTableAdmin() {
        let createTableString = "CREATE TABLE IF NOT EXISTS admin (userid INTEGER AUTO INCREMENT PRIMARY KEY,username TEXT,password TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("admin table created.")
            } else {
                print("admin table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertAdmin(username:String, password:String)
    {
//        let admin = readadmin()
//        for f in admin
//        {
//            if f.userid == userid
//            {
//                return
//            }
//        }
        let insertStatementString = "INSERT INTO admin (userid, username, password) VALUES (NULL, ?, ? );"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (password as NSString).utf8String, -2, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readadmin() -> [Admins] {
        let queryStatementString = "SELECT * FROM admin;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Admins] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let userid = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                psns.append(Admins(userid: Int(userid), username: username, password: password))
                print("Query Result:")
                print("\(userid) | \(username) | \(password)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func readadmin(username:String,password:String) -> [Admins] {
        let queryStatementString = "SELECT * FROM admin WHERE username=? AND password=?;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Admins] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let userid = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                psns.append(Admins(userid: Int(userid), username: username, password: password))
                print("Query Result:")
                print("\(userid) | \(username) | \(password)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
        
        func insert(id:Int, nama:String, kategori:String, stok:Int, harga:Double)
        {
            let furniture = read()
            for f in furniture
            {
                if f.id == id
                {
                    return
                }
            }
            let insertStatementString = "INSERT INTO furniture (id, nama, kategori, stok, harga) VALUES (NULL, ?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                
                sqlite3_bind_text(insertStatement, 1, (nama as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (kategori as NSString).utf8String, -2, nil)
                sqlite3_bind_int(insertStatement, 3, Int32(stok))
                sqlite3_bind_int(insertStatement, 4, Int32(harga))
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
        
        func read() -> [Furnitur] {
            let queryStatementString = "SELECT * FROM furniture;"
            var queryStatement: OpaquePointer? = nil
            var psns : [Furnitur] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id = sqlite3_column_int(queryStatement, 0)
                    let nama = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let kategori = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let stok = sqlite3_column_int(queryStatement, 3)
                    let harga = sqlite3_column_int(queryStatement, 4)
                    psns.append(Furnitur(id: Int(id), nama: nama, kategori: kategori, stok: Int(stok),harga:Double(harga)))
                    print("Query Result:")
                    print("\(id) | \(nama) | \(kategori) | \(stok) | \(harga)")
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return psns
        }
        
        func deleteByID(id:Int) {
            let deleteStatementStirng = "DELETE FROM furniture WHERE id = ?;"
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(deleteStatement, 1, Int32(id))
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted row.")
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            sqlite3_finalize(deleteStatement)
        }
    
    func editData(nama: String, kategori: String, stok: Int, harga: Double, id: Int){
        
        let updateStatementString = "UPDATE furniture SET nama = ?, kategori = ?, stok = ?, harga  =? WHERE id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(updateStatement, 1, (nama as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (kategori as NSString).utf8String, -2, nil)
            sqlite3_bind_int(updateStatement, 3, Int32(stok))
            sqlite3_bind_double(updateStatement, 4, Double(harga))
            sqlite3_bind_int(updateStatement, 5, Int32(id))
            
            while sqlite3_step(updateStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(updateStatement, 0)
                let nama = String(describing: String(cString: sqlite3_column_text(updateStatement, 1)))
                let kategori = String(describing: String(cString: sqlite3_column_text(updateStatement, 2)))
                let stok = sqlite3_column_int(updateStatement, 3)
                let harga = sqlite3_column_int(updateStatement, 4)
                print("Query Result:")
                print("\(id) | \(nama) | \(kategori) | \(stok) | \(harga)")
            }
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not updated row.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
//        let editStatementString = "UPDATE FROM durniture WHERE id;"
        
    }
        
    }
