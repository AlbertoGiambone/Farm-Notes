//
//  HomeTV.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 24/12/21.
//

import Foundation


struct HomeTV {
    
    var type: String
    var title: String
    var body: String
    var date: Date
    var UID: String
    var DID: String
    
    var dict: [String: Any] {
    return [
    
        "type": type,
        "title": title,
        "body": body,
        "date": date,
        "UID": UID,
        "DID": DID
        
        ]
        
    }
    
    
}
