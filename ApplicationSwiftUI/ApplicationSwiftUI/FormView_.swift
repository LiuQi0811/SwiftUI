//
//  FormView_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/21.
//

import SwiftUI

struct FormView_: View {
    var body: some View {
        //创建Form 表单视图 最大限制 10个视图 超出10个会报错
                //可以使用 VStack HStack ZStack Group 解决限制的问题
                Form{
                    
                    Group{
                        Section("文本"){
                            Text("Hello")
                            Text("Hello")
                            Text("Hello")
                            Text("Hello")
                        }
                    }
                    
                    Group{
                        Section("图片")
                        {
                            Image("Blu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height: 100)
                            Image("Friend")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height: 100)
                            Image("Hopper")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height: 100)
                            
                        }
                    }
                    
                    Group{
                        Section(){
                            HStack{
                                Text("猴子")
                                Spacer()
                                Text("🐒")
                            }
                            .font(.title)
                        }
                        Section(){
                            HStack{
                                Text("狐狸")
                                Spacer()
                                Text("🦊")
                            }
                            .font(.title)
                        }
                        Section(){
                            HStack{
                                Text("老虎")
                                Spacer()
                                Text("🐯")
                            }
                            .font(.title)
                        }
                    }
                    
                    
                }
    }
}

struct FormView__Previews: PreviewProvider {
    static var previews: some View {
        FormView_()
    }
}
