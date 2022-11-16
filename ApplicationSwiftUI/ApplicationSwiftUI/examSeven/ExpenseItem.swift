//
//  ExpenseItem.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/11/14.
//

import Foundation

class ExpenseItem: Identifiable,Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
    
}
