//
//  DatabaseHelper.swift
//  ios-airports
//
//  Created by Robin Post on 17/10/2017.
//  Copyright © 2017 Robin Post. All rights reserved.
//

import Foundation

class DatabaseHelper : NSObject {
    static let instance = DatabaseHelper()
    
    var db : OpaquePointer? = nil
    
    override init() {
        super.init()
        
        let bundlePathUrl = Bundle.main.url(forResource: "airports", withExtension: "sqlite")
        let docPathUrl = getDocumentsDirectory().appendingPathComponent("airports.sqlite")
        
        if !FileManager.default.fileExists(atPath: docPathUrl.path) {
            try! FileManager.default.copyItem(at: bundlePathUrl!, to: docPathUrl)
        }
        
        if sqlite3_open(docPathUrl.path, &db) != SQLITE_OK {
            print("Error opening database!!")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0];
    }
    
    func read() -> Array<Airport> {
        
        // Empty array
        var result = Array<Airport>()
        
        // Query
        let query = "SELECT * FROM airports;"
        
        // Prepare query and execute
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error query: \(errmsg)")
        }
        
        // Construct names
        while sqlite3_step(statement) == SQLITE_ROW {
//            let firstname = String(cString: sqlite3_column_text(statement, 1));
//            let lastname = String(cString: sqlite3_column_text(statement, 2));
//            result.append(firstname.lowercased() + " " + lastname.uppercased())
            
//            let id = Int(CInt: sqlite3_column_text(statement, 1))
            let icao = String(cString: sqlite3_column_text(statement, 0))
            let name = String(cString: sqlite3_column_text(statement, 1))
            result.append(Airport(ident: icao, name: name))
        }
        
        return result
    }
}
