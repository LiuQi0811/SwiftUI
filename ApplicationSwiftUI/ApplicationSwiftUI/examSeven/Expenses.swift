//
//  Expenses.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/11/14.
//

import Foundation

class Expenses : ObservableObject{
    @Published var items : [ExpenseItem] = []
}
