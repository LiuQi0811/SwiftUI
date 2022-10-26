//
//  TextFieldView_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/23.
//

import SwiftUI

struct TextFieldView_: View {
    @State private  var checkAmount = 0.0
    var body: some View {
        //创建 Form 表单视图
        Form{
            // 创建分组内容视图
            Section("格式化美元"){
                //创建 可编辑文本框
                TextField("美元数量",value: self.$checkAmount,format: .currency(code: "USD"))
            }
            Section("格式化加元"){
                //创建 可编辑文本框
                TextField("加元数量",value: self.$checkAmount,format: .currency(code: "CAD"))
            }
            Section("格式化澳元"){
                //创建 可编辑文本框
                TextField("澳元数量",value: self.$checkAmount,format: .currency(code: "AUD"))
            }
            Section("格式化人民币"){
                //创建 可编辑文本框
                TextField("人民币数量",value: self.$checkAmount,format: .currency(code: "CNY"))
            }
            
            Section(){
                TextField(".",value: self.$checkAmount,format: .currency(code: Locale.current.currencyCode ?? "CNY")).keyboardType(.decimalPad)
            }
        }
    }
}

struct TextFieldView__Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView_()
    }
}
