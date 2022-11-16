//
//  ContentView.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/11/10.
//

import SwiftUI




struct CornerRotateModifier: ViewModifier{
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading),
        identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}








/**
 转换内容视图
 */
struct TransitionsContentView: View{
    @State private var isShowingRed = false
    var body: some View{
        VStack{
            Button("哈哈哈哈"){
                self.isShowingRed.toggle()
                
            }
            .ButtonStyle()
           
            if(isShowingRed){
                Rectangle()
                   .fill(Color.red)
                   .frame(width: 200, height: 200)
                   .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
   
}

// 添加扩展
extension Button{
    func ButtonStyle() -> some View{
        self
            .padding(20)
            .padding(.horizontal,30)
            .background(.blue)
            .opacity(0.7)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .foregroundColor(.white)
            .animation(.easeInOut(duration: 1).delay(10).repeatCount(3,autoreverses: true), value: 1)
        
    }
}

/**
 SnakeLetters内容视图
 */
struct SnakeLettersContentView: View{
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    var body: some View{
        HStack{
            ForEach(0..<letters.count,id: \.self){ num in
                Text(String(letters[num]))
                    .padding(4)
                    .font(.title)
                    .background(self.enabled ? .blue  : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(num / 20)),value: dragAmount)
                    .mask{
                        Circle()
                    }
            
                    
                    
                    
            }
        }
        // 添加手势
        .gesture(
        // 拖拽手势
            DragGesture()
                .onChanged{
                    self.dragAmount  = $0.translation
                }
                .onEnded{ _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
    }
}

/**
 动画手势内容视图
 */
struct AnimatingGesturesContentView:View{
    @State private var dragAmount = CGSize.zero
    var body: some View{
            LinearGradient(colors: [.yellow,.red], startPoint: .topLeading, endPoint: .bottomTrailing)
                // 添加 frame 框架尺寸 宽300 高 200
                .frame(width: 300,height: 200)
                // 裁剪 圆角矩形
                .clipShape(RoundedRectangle(cornerRadius: 10))
                // 添加偏移量
                .offset(dragAmount)
                // 添加手势
                .gesture(
                    // 添加拖拽手势
                    DragGesture()
                    // 正在发生的事件
                        .onChanged{
                            // 增加偏移量
                            self.dragAmount = $0.translation
                        }
                    // 结束发生的事件
                        .onEnded{ _ in
                            withAnimation(.spring()){
                                // 偏移量恢复 回到原来的位置
                                self.dragAmount = .zero
                            }
                        }
                )
            
        }
    }



/**
 控制动画堆栈内容视图
 */
struct ControllingTheAnimationStackContentView:View{
    // 创建开关
    @State private var enabled: Bool = false
    var body: some View{
        Button("GCG"){
            self.enabled.toggle()
        }
        .background(self.enabled ? Color.blue : Color.red)
        // 添加frame 框架 宽400 高200
        .frame(width: 200,height: 200)
        .animation(nil,value: enabled)
        // 添加白色前景色
        .foregroundColor(.white)
        // 矩形圆角 裁剪
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        // 添加动画效果
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
}

/**
 显式动画内容视图
 */
struct ExplicitAnimationContentView: View{
    @State private var animationAmount = 0.0
    var body: some View{
        VStack{
            // 创建按钮
            Button("瞅啥瞅"){
                // interpolatingSpring 插值弹簧
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                    self.animationAmount += 360
                }
            }
            // 添加50边距
            .padding(50)
            // 添加黄色背景
            .background(Color.yellow)
            // 添加白色前景色
            .foregroundColor(.white)
            // 添加圆形 裁剪
            .clipShape(Circle())
            // 添加 旋转3D效果
            // degrees 旋转角度
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0,y:1,z: 0))
        }
    }
}


/**
 动画绑定内容视图
 */
struct AnimatedBindingsContentView: View{
    @State private var animationAmount :CGFloat = 1
    var body: some View{
        print(animationAmount)
        return VStack{
            // 创建步进器
            Stepper("Scale Amount :  \(animationAmount.formatted())",value: self.$animationAmount.animation(
            // 添加动画效果
                .easeInOut(duration: 1)
                // 添加一直重复效果
                .repeatCount(3,autoreverses: true)
            ),in: 1...10)
             
            Button(){
                // action ...操作逻辑
                animationAmount  += 1
            }label: {
                Text("Tap Me")
            }
            // 添加 40 边距
            .padding(40)
            // 添加 紫色背景
            .background(.purple)
            // 添加白色前景色
            .foregroundColor(.white)
            // 添加圆形 裁剪
            .clipShape(Circle())
            // 添加缩放效果
            .scaleEffect(animationAmount)
            
        }
    }
}

/**
 自定义动画内容视图
 */
struct CustomAnimationContentView:View{
    @State private var animationAmount :CGFloat = 1
    var body: some View{
        Button("Tap Me !"){
//            self.animationAmount += 1
        }
        // 添加 40边距
        .padding(40)
        // 添加绿色背景
        .background(.green)
        // 添加白色前景色
        .foregroundColor(.white)
        // 添加圆形
        .clipShape(Circle())
        // 添加缩放效果
        .scaleEffect(animationAmount)
        // 创建覆盖
        .overlay{
            // 添加圆形
            Circle()
                .stroke(.red)
                // 添加缩放效果
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(.easeOut(duration: 1)
                    // 一直重复 动画效果
                    .repeatForever(autoreverses: false)
                           , value: animationAmount)
        }
        // 创建生命周期 一开始出现时
        // 初始化视图实例——注册数据依赖——调用 body 计算结果——onAppear——销毁实例——onDisapper
        .onAppear{
            self.animationAmount = 2
        }
    }
}


struct AnimationView: View {
    @State private var animationAmount:CGFloat = 1
    var body: some View {
        ScrollView{
            VStack{
                VStack{
                    
                }
                VStack{
                    TransitionsContentView()
                    Spacer()
                    SnakeLettersContentView()
                    Spacer()
                    AnimatingGesturesContentView()
                    Spacer()
                    ControllingTheAnimationStackContentView()
                }
        
                ExplicitAnimationContentView()
                
                Spacer()
                
                AnimatedBindingsContentView()
                
                Spacer()
            
                CustomAnimationContentView()
                
                Spacer()
                
                // 创建 Tap Me 按钮
                Button("Tap Me"){
                    // action .... 操作的逻辑
                    self.animationAmount += 1
                    
                }
                // 添加 50边距
                .padding(50)
                // 添加红色背景
                .background(.red)
                // 添加白色前景色
                .foregroundColor(.white)
                // 添加圆形
                .clipShape(Circle())
                // 添加缩放效果
                .scaleEffect(animationAmount)
                // 添加模糊效果
                .blur(radius: (animationAmount - 1) * 3)
                // 添加默认动画效果
                .animation(.default,value: self.animationAmount)
            }
        }
    }
}

struct ContentView_Six_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
