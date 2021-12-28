//
//  Fertilizer.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 30/11/21.
//

import Foundation

struct FertilizationNote {
    
    var type: String
    var title: String
    var fertNotes: String
    var fertDate: Date
    var distribution: String
    var UID: String
    var DID: String
    
    var dict: [String: Any] {
        return[
        
            "type": type,
            "title": title,
            "fertNotes": fertNotes,
            "fertDate": fertDate,
            "distribution": distribution,
            "UID": UID,
            "DID": DID
        
        ]
        
    }

}


