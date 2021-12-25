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
    var UID: String
    var DID: String
    
    var dict: [String: Any] {
        return[
        
            "type": type,
            "title": title,
            "fertNotes": fertNotes,
            "fertDate": fertDate,
            "UID": UID,
            "DID": DID
        
        ]
        
    }

}


struct FertDistribution {
    
    var N: String
    var P: String
    var K: String
    var kg: String
    var fertDate: Date
    var UID: String
    var DID: String
    
    var dict: [String: Any] {
        return[
        
            "N": N,
            "P": P,
            "K": K,
            "kg": kg,
            "fertDate": fertDate,
            "UID": UID,
            "DID": DID
        ]
    }
}

