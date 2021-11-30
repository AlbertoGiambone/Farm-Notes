//
//  Fertilizer.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 30/11/21.
//

import Foundation


struct Fertilization {
    
    var N: String
    var P: String
    var K: String
    var kg: String
    var fertDate: Date
    var UID: String
    
    var dict: [String: Any] {
        return[
        
            "N": N,
            "P": P,
            "K": K,
            "kg": kg,
            "fertDate": fertDate,
            "UID": UID
        
        ]
        
    }
    
    
}