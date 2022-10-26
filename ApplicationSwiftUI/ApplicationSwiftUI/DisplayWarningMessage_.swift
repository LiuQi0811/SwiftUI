//
//  DisplayWarningMessage_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/25.
//

import SwiftUI

struct DisplayWarningMessage_: View {
    //动态绑定 是否显示警报信息
    @State private var showWarning = false
    var body: some View {
        VStack{
            Button("显示⚠️"){
                self.showWarning = true
            }
            .alert("你已经 越界了，请回去 ！",isPresented: self.$showWarning){
                Button("确认"){}
                Button("取消",role: .cancel){}
                
            }message: {
                Text("这里显示的信息")
            }
            
        }
    }
}

struct DisplayWarningMessage__Previews: PreviewProvider {
    static var previews: some View {
        DisplayWarningMessage_()
    }
}
