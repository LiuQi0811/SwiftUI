//
//  AddView.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/11/15.
//

import SwiftUI

struct AddView: View {
    @StateObject var expenses: Expenses
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var amount = 0.0
    // 商品类型列表
    var types :[String] = ["牛奶","水果","零食","饮料","生鲜"]
    
    // 隐藏
    @Environment(\.dismiss) var diamiss
    var body: some View {
        // 创建导航栏视图
        NavigationView{
            // 创建form 表单视图
            Form{
                // 创建可编辑文本框
                TextField("商品姓名",text: self.$name)
                
                
                // 创建下拉框
                Picker("商品类型",selection: self.$type){
                    ForEach(self.types,id: \.self){
                        Text($0)
                    }
                   
                }
                // 设置 下拉框样式
                .pickerStyle(.automatic)
                
                TextField("商品金额",value: self.$amount, format: .currency(code: "CNY"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("添加新的商品")
            // 创建工具栏
            .toolbar
            {
                
                HStack{
                    Button("取消"){
                        diamiss()
                    }
                    
                    Spacer()
                    
                    Button("保存"){
                        addContent(name: self.name, type: self.type, amount: self.amount)
                        // 关闭操作
                        diamiss()
                    }
                    
                
                }
            }
           
            
        }
    }
    
    
    // 添加数据方法
    func addContent(name: String,type: String, amount: Double) -> Void
    {
        // 列表塞值
        expenses.items.append(ExpenseItem(name: name, type: type, amount: amount))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
