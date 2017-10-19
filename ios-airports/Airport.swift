//
//  Airport.swift
//  ios-airports
//
//  Created by Robin Post on 17/10/2017.
//  Copyright © 2017 Robin Post. All rights reserved.
//

import Foundation

class Airport : NSObject {
    var ident : String!
    var name : String!
    
    init(ident: String, name: String) {
        self.ident = ident
        self.name = name
    }
    
    subscript (i: Int) -> Int {
        return Int(self[i] as Int)
    }
}
