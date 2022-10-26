//
//  WeSplit.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/25.
//

import SwiftUI

struct WeSplit: View {
    @State private var checkAmount = 0.0
    @FocusState private var  amountIsFocused: Bool
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
       // 创建 导航栏视图
        NavigationView(){
            // 创建Form 表单视图
            Form{
                // 创建分组内容视图
                Section{
                    // 创建可编辑文本框
                    // 文本绑定 只接受String的 Binding<String> 需要把Double format
                    TextField("总计",value: self.$checkAmount,format: .currency(code: Locale.current.currencyCode ?? "CNY"))
                        // 设置键盘类型
                        .keyboardType(.decimalPad)
                        // 设置聚焦
                        .focused(self.$amountIsFocused)
                    
                    //创建下拉选择框
                    // selection 绑定选择的数据
                    Picker("人数",selection: self.$numberOfPeople){
                        ForEach(2 ..< 10){
                            Text("\($0) 人")
                        }
                    }
                }
                // 创建分组内容视图
                Section{
                    // 创建下拉选择器
                    Picker("小费百分率",selection: self.$tipPercentage){
                        ForEach(self.tipPercentages,id: \.self)
                        {
                            // format 格式化 .percent 百分比
                            Text($0, format: .percent)
                        }
                    }
                    // 设置 选择器的样式
                    .pickerStyle(.segmented)
                }header: {
                    Text("你想给多少小费?")
                }
                
                // 创建分组内容视图
                Section{
                    Text(self.totalPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            // 设置 导航栏标题
            .navigationTitle("我们的份额")
            // 创建工具栏
            .toolbar{
                // 创建工具栏 组
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("完成"){
                        amountIsFocused  = false
                    }
                }
            }
        }
    }
}

struct WeSplit_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit()
    }
}
