//
//  ViewsAndModifiers.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/26.
//

import SwiftUI

/**
 创建格言视图
 */
struct MottoView: View{
    let mottonOne = Text("慈母手中线，游子身上衣。")
    let mottonTwo = Text("一寸光阴一寸金，寸金难买寸光阴。")
    var body: some View{
        //创建 垂直堆栈视图
        //设置 10 间距
        VStack(spacing: 10){
            mottonOne
            // 设置 红色字体
                .foregroundColor(.red)
            mottonTwo
            // 设置 蓝色字体
                .foregroundColor(.blue)
            //调取 .modifier() 拓展
            Text("名言警句").titleStyle()
        }
        
    }
}

/**
 创建 胶囊文本视图
 */
struct CapsuleText: View{
    var text: String
    var body: some View{
        //创建 垂直堆栈视图
        VStack{
            Text(self.text)
                // 设置 大标题字体
                .font(.largeTitle)
                // 设置 边距
                .padding()
                // 设置 白色字体
                .foregroundColor(.white)
                // 设置 蓝色的背景色
                .background(.blue)
                // 裁剪 胶囊形状
                .clipShape(Capsule())
        }
    }
}

/**
 *创建标题视图
 */
struct Title: ViewModifier{
    // 创建主体函数方法 返回视图
    func body(content: Content) -> some View {
        content
        // 设置 大标题字体
            .font(.largeTitle)
        // 设置 边距
            .padding()
        // 设置 白色字体
            .foregroundColor(.white)
        // 设置 蓝色的背景色
            .background(.blue)
        // 裁剪 圆角矩形形状
            .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}
/**
 创建标题视图 拓展
 */
extension View{
    func titleStyle() -> some View{
        self.modifier(Title())
    }
}

/**
 创建水印视图
 */
struct Watermark: ViewModifier{
    var text: String
    // 创建主体函数方法 返回视图
    func body(content: Content) -> some View {
        //创建 层叠 堆栈视图
        ZStack{
            content
            Text(text)
            // 设置 说明字体
                .font(.caption)
            // 设置 白色字体
                .foregroundColor(.white)
            // 设置 5边距
                .padding(5)
            // 设置 黑色背景色
                .background(.black)
            // 设置 3D 旋转
                .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
            // 设置 阴影
                .shadow(radius: 8)
        }
    }
}

/**
 创建水印视图 拓展
 */
extension View{
    func watermarked(with text: String) -> some View{
        self.modifier(Watermark(text: text))
    }
}


/**
 创建 栅栏视图
 */
struct  GridStack<Content: View>: View{
    let rows: Int
    let columns: Int
    let content: (Int,Int) -> Content
    
    //构造方法初始化
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }

    var body: some View{
        //创建 垂直 堆栈视图
        VStack{
            ForEach(0 ..< self.rows,id: \.self){ row in
                //创建 水平堆栈视图
                HStack{
                    ForEach(0 ..< self.columns,id: \.self){ column in
                        self.content(row,column)
                    }
                }
            }
        }
    }
}



struct ViewsAndModifiers: View {
    var body: some View {
        // 创建 垂直 堆栈视图
        VStack{
            ZStack{
                Color.blue
                //添加水印
            }
            .frame(width: 200,height: 200)
            .watermarked(with: "刘奇之印")
            
            Text("ViewsAndModifiers")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
            
            Button("ViewsAndModifiers"){
                print(type(of: self.body))
            }
            .frame(width: 200,height: 100)
            .background(.purple)
            
            VStack(alignment:.center ,spacing: 10){
                CapsuleText(text: "春眠不觉晓，")
                CapsuleText(text: "处处闻啼鸟。")
            }
            
            GridStack(rows: 4 ,columns: 4 ){ row,col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
            
        }
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAndModifiers()
    }
}
