//
//  GuessTheFlag.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/26.
//

import SwiftUI

struct GuessTheFlag: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    // 分数
    @State private var score: Int = 0
    //创建国家列表
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
       // 创建层叠堆栈视图
        ZStack{
            //创建角度渐变
            RadialGradient(gradient: Gradient(stops: [
                .init(color: Color(red: 0.1,green: 0.2,blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76,green: 0.15,blue: 0.26), location: 0.3)
            ]), center: .top, startRadius: 200, endRadius: 700)
            // 设置 忽略安全区域 填充边缘空白
            .ignoresSafeArea()
            //创建 水平垂直堆栈视图
            VStack{
                Spacer()
                Text("猜国旗")
                // 设置 字体大标题 加粗
                    .font(.largeTitle.bold())
                // 设置白色的字体
                    .foregroundColor(.white)
                
                //创建 水平垂直堆栈视图
                VStack(spacing: 15){
                    VStack{
                        Text("轻拍国旗")
                        // 设置 前景色样式   .secondary
                            .foregroundStyle(.secondary)
                        // 设置 字体 副标题 加粗
                            .font(.subheadline.weight(.heavy))
                    
                        Text(self.getCountryChinaName(name: countries[correctAnswer]))
                                // 设置 字体 大标题 半粗体
                                    .font(.largeTitle.weight(.semibold))
                
                       
                    }
                    
                    // ForEach 循环遍历
                    ForEach(0 ..< 4){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(self.countries[number])
                            // .renderingMode(.original)修饰符强制SwiftUI显示原始图像，而不是重新着色的版本
                                .renderingMode(.original)
                            // 设置裁剪 胶囊形状
                                .clipShape(Capsule())
                            // 设置阴影 5
                                .shadow(radius: 5)
                        
                        }
                    }
                }
                // 设置 框架大小
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("成绩：\(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        // 提示框
        .alert(scoreTitle,isPresented: self.$showingScore) {
            Button("继续",action: askQuestion)
        }message: {
            Text(" 你的成绩是： \(self.score)")
        }
    }
    
    func flagTapped( _ number: Int){
        if(number == self.correctAnswer){
            scoreTitle = "正确"
            self.score += 10
        }else{
            scoreTitle = "错误"

            if(self.score == 0){
                self.score = 0
            }else{
                self.score -= 10
            }
    
        }
        self.showingScore = true
    }
    
    // 有效提问方法
    func askQuestion(){
        //获取 国家列表 重新排序
        self.countries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
    }
    
    
    
    

    // 获取国家名字
    func getCountryChinaName(name: String)-> String
    {
      // 定义返回的变量
        var result: String = ""
        
        if(name == "Estonia"){
            result = "爱沙尼亚"
        }else if (name == "France"){
            result = "法国"
        }
        else if (name == "Germany"){
            result = "德国"
        }
        else if (name == "Ireland"){
            result = "爱尔兰"
        }
        else if (name == "Italy"){
            result = "意大利"
        }
        else if (name == "Nigeria"){
            result = "尼日利亚"
        }else if (name == "Poland"){
            result = "波兰"
        }else if (name == "Russia"){
            result = "俄罗斯"
        }
        else if (name == "Spain"){
            result = "西班牙"
        }
        else if (name == "UK"){
            result = "英国"
        }
        else if (name == "US"){
            result = "美国"
        }
        
       return result
        
    }
}



struct GuessTheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}

