//
//  View.swift
//  Naseem
//

import Foundation



struct LError {
    var error : String!
    var errorDescription : String!
    var messge : String!
    init( error : String , errorDescription : String) {
        self.error = error
        self.errorDescription = errorDescription
    }
    init(messge : String) {
        self.messge = messge
    }
}
