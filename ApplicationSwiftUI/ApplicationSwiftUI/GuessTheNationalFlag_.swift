//
//  GuessTheNationalFlag_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/25.
//

import SwiftUI

struct GuessTheNationalFlag_: View {
    //按钮点击次数统计 声明字段
    @State private  var tapCount = 0;
    var body: some View {
        VStack{
            gradientView()
            Button{
                self.tapCount += 1
                print("点击了\(tapCount) 次按钮！")
            }label: {
                Text("按下我")
            }
            
            Button
            {
                print("这是一只铅笔 ？")
            }label: {
                Image(systemName: "pencil")
            }
            .padding(10)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            //添加阴影
            .shadow(radius: 20)
            
            Button{
                print("这是一只钢笔 ！")
            }label: {
                Label("编辑",systemImage: "square.and.pencil")
            }
            .shadow(color: .pink,radius: 20)
            
            
            
            Spacer()
        }
    }

}
//堆栈 排列视图相关
func stackCollection() -> some View{
    VStack{
        //创建垂直视图
        VStack(spacing: 20){
            Text("白日依山尽，")
            Text("黄河入海流。")
            Spacer()
        }
        //创建水平视图
        HStack(spacing: 20){
            Text("欲穷千里目，")
            Text("更上一层楼。")
        }
        //创建层叠视图
        ZStack{
            //设置整个区域 全部都是红色 将颜色放入ZStack中
            //事实上，Color.red本身就是一个视图，这就是为什么它可以像形状和文本一样使用。
            Color.red
            Text("月落乌啼霜满天")
        }
        //设置红色的背景色
        .background(.red)
        //设置 frame 来指定特定的尺寸
        .frame(width: 300,height: 300)
        
        
        ZStack{
            VStack(spacing: 0){
                Color.blue
                Color.mint
            }
            Text("江枫渔火对愁眠")
            //设置前景色
                .foregroundColor(.secondary)
            //设置边距 各50
                .padding(50)
            //设置背景色
                .background(.ultraThinMaterial)
        }
        //如果您希望内容位于安全区域下方，您可以使用.ignoresSafeArea()修饰符来指定要运行到哪些屏幕边缘
        .ignoresSafeArea()
}
}

//梯度相关
//梯度由几个组件组成：
//要显示的一系列颜色
//尺寸和方向信息
//要使用的渐变类型

func gradientView() -> some View{
    VStack{
        //设置渐变色  黑白
        LinearGradient(gradient: Gradient(colors: [.white,.black]),startPoint: .top,endPoint: .bottom)
            .frame(width:400,height: 400)
        //设置渐变色从开始到可用空间的45%，我们的梯度应该是白色的，然后从可用空间的55%开始应该是黑色的
        LinearGradient(gradient: Gradient(stops: [
            Gradient.Stop(color: .white, location: 0.45),
            Gradient.Stop(color: .black, location: 0.55)
        ]),startPoint: .top,endPoint: .bottom)
        .frame(width:400,height: 400)
        
        LinearGradient(gradient: Gradient(stops: [.init(color: .white, location: 0.45),
                                                  .init(color: .black, location: 0.55)]), startPoint: .top, endPoint: .bottom)
        .frame(width:400,height: 400)
        
        HStack{
            //径向渐变
            RadialGradient(gradient: Gradient(colors: [.blue,.black]), center: .center, startRadius: 20, endRadius: 200)
                .frame(width:400,height: 400)
            Spacer()
            
            //角度渐变
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                .frame(width:400,height: 400)
            
        }
    }
    
    
}

func buttonAndImageView() -> some View{
    VStack{
        NavigationView(){
            VStack{
                Button("删除内容"){
                    print("正在删除。。。。。")
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.red)
                Button("新增内容",role: .destructive,action: {
                    insert()
                })
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .shadow(radius: 20)
                
                
            }
            .navigationTitle("按钮与图片")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.secondary)
            
    }
        
    }
    

}

//新增方法
func insert()
{
    print("内容新增中。。。。")
}

struct GuessTheNationalFlag__Previews: PreviewProvider {
    static var previews: some View {
        GuessTheNationalFlag_()
    }
}
