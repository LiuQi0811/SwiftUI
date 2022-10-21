//
//  CreateLoopView_.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/21.
//

import SwiftUI

struct CreateLoopView_: View {
    //创建学生参数
    //学生名称
    @State var studentName: String = ""
    //学生年龄
    @State var studentAge: String = "0"
    //学生地址
    @State var studentAddress: String = ""
    
    
    @State var studentInfos: [Student] = getStudents(name: "", age: "", address: "")
    var body: some View {
        // 创建循环视图
                
                VStack{
                    // 设置 Form表单视图
                    Form{
                        // ForEach循环 区间 0 - 3
                        ForEach(0 ..< 4,id:\.self){ number in
                            Text("Row .  \(number)")
                        }
                        
                        // ForEach循环 区间 4 - 6
                        ForEach(4 ... 6,id: \.self){
                            Text("Row .  \($0)")
                        }
                        
                        //遍历学生信息
                        ForEach(getStudents()){ student in
                            Text("学生信息：  姓名：\(student.name!)     年龄：\(student.age!)     地址：\(student.address!) ")
                                .foregroundColor(.blue)
                        }
                        
                        Section{
                            Text("学生信息")
                                .padding()
                            Text("姓名\t\t\t\t\t年龄\t\t\t\t\t地址")
                            //学生信息展示框
                            ForEach(studentInfos){ info in
                                
                                Text("\(info.name!)\t\t\t\t\t\(info.age!)\t\t\t\t\t\t\(info.address!)")
                            }
                        }
                        
                    }
                    
                    
                    //  创建分组
                    Group{
                        
                        // 目标：做一个输入学生信息 然后动态绑定 展示输入的内容信息
                        //创建Form 表单视图
                        Form{
                            
                            // 创建分组内容视图
                            Section("学生名称："){
                                // 设置 可编辑文本框
                                TextField("请输入学生名称",text: self.$studentName)
                            }
                            
                            Section("学生年龄"){
                                TextField("请输入学生年龄",text: self.$studentAge)
                            }
                            Section("学生地址"){
                                // 设置 可编辑文本框
                                TextField("请输入学生地址",text: self.$studentAddress)
                                
                            }
                            
                            //新增学生信息按钮
                            Button("新增学生信息"){
                                //获取学生信息集合
                                self.studentInfos.append(Student(name: studentName, age: studentAge, address: studentAddress))
                            }
                            
                        }
                        
                    }
                    
                    
                }

    }
}

struct Student: Identifiable
{
    private(set) var id: UUID?
    var name: String?
    var age: String?
    var address: String?
    init(name: String,age: String,address: String){
        self.id = UUID()
        self.name = name
        self.age = age
        self.address = address
    }
    
}

//创建返回学生集合信息的方法 无参数
func getStudents() ->[Student]
{
    //创建学生空数组
    var students:[Student] = []
    //创建学生对象
    var student = Student(name: "云悠悠", age: "18", address: "徐州云龙区")
    //学生空数组新增学生对象信息
    students.append(student)
    return students
}


//创建返回学生集合信息的方法 有参数
func getStudents(name: String,age: String,address: String) -> Array<Student>
{
    //创建学生空数组
    var students: Array<Student> = []
    return students
}

struct CreateLoopView__Previews: PreviewProvider {
    static var previews: some View {
        CreateLoopView_()
    }
}
