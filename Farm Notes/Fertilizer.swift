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
    var N: String
    var P: String
    var K: String
    var kg: String
    var fertDate: Date
    var UID: String
    
    var dict: [String: Any] {
        return[
        
            "type": type,
            "title": title,
            "fertNotes": fertNotes,
            "N": N,
            "P": P,
            "K": K,
            "kg": kg,
            "fertDate": fertDate,
            "UID": UID
        
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

