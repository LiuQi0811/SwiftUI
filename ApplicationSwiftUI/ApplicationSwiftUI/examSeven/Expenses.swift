//
//  Expenses.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/11/14.
//

import Foundation

class Expenses : ObservableObject{
    @Published var items =  [ExpenseItem](){
        didSet{
            if let encoder =  try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoder, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decoderItems = try? JSONDecoder().decode([ExpenseItem].self,from: savedItems){
                items = decoderItems
                return
            }
        }
        
        items = []
    }
}
