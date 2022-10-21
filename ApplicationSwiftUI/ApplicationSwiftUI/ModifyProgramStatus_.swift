//
//  ModifyProgramStatus_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/21.
//

import SwiftUI

struct ModifyProgramStatus_: View {
    // 定义点击次数
    // @State 可以保存 修改 数据状态
    // 可以在SwiftUI中存储程序状态
    @State var tapCount = 0
    //定义用户名
    @State var username = ""
    @State var password = ""
    var body: some View {
        // 修改程序状态
        VStack{
            Button("点击次数 \(tapCount) 次"){
                self.tapCount += 1
            }
            //设置 边距
            .padding()
            //设置字体 标题3
            .font(.title3)
            //设置白色的背景
            .background(.white)
            //设置裁剪 矩形圆角边框
            .clipShape(RoundedRectangle(cornerRadius: 12))
            //设置 阴影
            .shadow(radius: 18)
            //设置 边距 38
            .padding(38)
            // 创建Form表单
            Form{
                
                // 创建可编辑的文本框
                TextField(text: self.$username)
                {
                    Label{
                        Text("请输入用户名称")
                    }icon: {
                        Image(systemName: "person.circle")
                    }
                }
                Text("展示输入的内容： \(self.username)")
                //设置前景色 灰色字体
                    .foregroundColor(.gray)
                
                
                //创建可编辑的密码框
                SecureField("请输入用户密码", text: self.$password)
                Text("展示输入的加密内容： \(self.password)")
                //设置前景色 灰色字体
                    .foregroundColor(.gray)
            }
        }
        
    }
}

struct ModifyProgramStatus__Previews: PreviewProvider {
    static var previews: some View {
        ModifyProgramStatus_()
    }
}
