//
//  BetterRest.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/27.
//

import SwiftUI
import CoreML

struct BetterRest: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        
        // 创建 垂直堆栈视图
        VStack{
            // 创建步进器 使用步进器输入数字
            // value 动态绑定的值
            // in 所输值的范围限制
            // step 限制每次增减的值 步数
            Stepper("\(sleepAmount.formatted()) 小时",value: self.$sleepAmount,in: 4 ... 12,step: 0.25)
            
            // 使用DatePicker选择日期和时间
            // selection 动态绑定的值
            // displayedComponents 来决定用户应该看到什么样的选项 如果您不提供此参数，用户会看到一天、小时和分钟。
            //如果您使用.date用户，请参阅月份、日期和年份。
            //如果您使用.hourAndMinute，用户只会看到小时和分钟组件。
            // in 限制日期范围  Date.now... 当前日期
            DatePicker("请选择日期", selection: self.$wakeUp,in: Date.now...)
            DateOfService().dateOfService()
            
            Spacer()
            
           
           
                // 创建导航栏视图
                NavigationView{
                    
                    // 创建 From 表单视图
                    Form{
                        
                        // 创建 垂直堆栈视图
                        VStack(alignment: .leading, spacing: 0){
                            
                            Text("你想什么时候起床?")
                                .font(.headline)
                            DatePicker("请选择时间",selection: self.$wakeUp ,displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            Text("期望的睡眠时间")
                                .font(.headline)
                            Stepper("\(sleepAmount.formatted())  小时",value: self.$sleepAmount,in: 4...12,step: 0.25)
                        }
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            Text("每日咖啡摄入量")
                                .font(.headline)
                            Stepper(coffeeAmount == 1 ? "1  杯" : "\(coffeeAmount)  杯",value: self.$coffeeAmount,in: 1...20)
                        }
                    }
                    .navigationTitle("BetterRest")
                    .toolbar{
                        
                        Button("预测",action: {
                            calculateBedtime()
                        })
                    }
                    .alert(alertTitle, isPresented: self.$showAlert){
                        
                        Button("OK"){}
                        
                    }message: {
                        
                        Text(alertMessage)
                    }
    
                    
                    
                }
            }
            
        
        
    
    }
    
    
    
    
    func calculateBedtime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "你理想的就寝时间是……"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "错误"
            alertMessage = "抱歉，计算你的就寝时间有问题。"
        }
        showAlert = true
    }
    
    

    
}




struct DateOfService{
    // 获取当前时间
    let now = Date.now
    // 获取明天时间
    let tomorrow = Date.now.addingTimeInterval(86400)
  
    
    
    /// 日期字符串转化为Date类型
      ///
      /// - Parameters:
      ///   - string: 日期字符串
      ///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
      /// - Returns: Date类型
    func stringConvertDate(string:String) -> Date {
        let dateFormatter = DateFormatter.init()
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let datetime = formatter.string(from: Date())
        return datetime
    }
    
    func chinaDate() -> String
    {
    let formatter = DateFormatter()
        formatter.dateStyle  = .full
        formatter.timeStyle = .full
        formatter.locale = Locale(identifier: "zh-CN")
        let datetime = formatter.string(from: Date())
        return datetime
    }

    
    // 日期中文格式化
    func getChinaDate() -> String{
     let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        formatter.locale = Locale(identifier: "zh-CN")
        // 农历日期
        formatter.calendar = Calendar.init(identifier: .chinese)
       let date = formatter.string(from: Date())
        return date
    }
    
    //创建使用日期方法
    func dateOfService() -> some View{
      
        VStack(spacing: 20){
            Text("现在时间： \(now)")
            Text("明天时间： \(tomorrow)")
            Text("现在到明天时间区间： \(now ... tomorrow)")
            Text("获取中文时间： \(getChinaDate())")
            Text("\(currentDate())")
            Text("\(chinaDate())")
        }
        .font(.subheadline)
        .foregroundColor(.white)
        .shadow(radius: 10)
        .padding(40)
        .background(.purple)
    }
}

struct BetterRest_Previews: PreviewProvider {
    static var previews: some View {
        BetterRest()
    }
}
