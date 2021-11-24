//
//  notes.swift
//  
//
//  Created by Alberto Giambone on 24/11/21.
//

import Foundation


struct notes {
    
    var title: String
    var body: String
    var date: Date
    var UID: String
    var DID: String
    
    var dict: [String: Any] {
        return[
        
            "title": title,
            "body": body,
            "date": date,
            "UID": UID,
            "DID": DID
            
        ]
    }
    
    
}
