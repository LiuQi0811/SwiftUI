//
//  NavigationView_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/21.
//

import SwiftUI

struct NavigationView_: View {
    var body: some View {
        //创建导航栏 视图
        NavigationView{
            //创建表单视图
            Form{
                //创建分层视图内容
                Section{
                    
                    Text("Hello World !")
                    
                }
                
            }
            // 设置 导航栏标题
            .navigationTitle("导航栏")
            //设置导航栏样式  居中小字体
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavigationView__Previews: PreviewProvider {
    static var previews: some View {
        NavigationView_()
    }
}
