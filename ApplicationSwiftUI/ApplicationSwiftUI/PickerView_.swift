//
//  PickerView_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/23.
//

import SwiftUI

struct PickerView_: View {
        @State private var selector = 0.0
        @State private var numberOfPeople = 0
        @State private var text = ""
        @FocusState private var isFocused: Bool
        var body: some View {
            
                VStack{
                    
                    Section{
                        TextField("。。。。。。",value: self.$selector,format: .currency(code: Locale.current.currencyCode ?? "CNY"))
                        
                        Picker("Number of People", selection: self.$numberOfPeople) {
                            ForEach(2 ..< 10){
                                Text(" \($0) People")
                                    .focused(self.$isFocused)
                            }
                        }
                        //设置选择器的 样式
                        .pickerStyle(.inline)
                    }
                    
                    NavigationView{
                    HStack{
                        Section("隐藏键盘:\t "){
                            // 创建可编辑文本框
                            TextField("  隐藏 ⌨️",text: self.$text)
                        }
                    }
                    .navigationTitle("隐藏 ⌨️")
                    .toolbar{
                        ToolbarItemGroup(placement: .keyboard){
                            Spacer()
                            Button("🎹 。。 ⌨️"){
                                self.isFocused = false
                            }
                        }
                    }
                        
                    }
                }
                
            
        }
}

struct PickerView__Previews: PreviewProvider {
    static var previews: some View {
        PickerView_()
    }
}
