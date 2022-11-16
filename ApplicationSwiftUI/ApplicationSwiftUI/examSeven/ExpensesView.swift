//
//  ExpensesView.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/11/14.
//

import SwiftUI

struct ExpensesView: View {
    
   @StateObject var expenses = Expenses()
   @State private var showingAddExpense = false
   
    var body: some View {

            // 创建导航栏视图
            NavigationView{
                List{
                    ForEach(expenses.items){ item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                Text(item.type)
                                Spacer()
                                Text(item.amount.formatted())
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                // 添加导航栏标题
                .navigationTitle("购物车🛒")
                // 创建 工具栏
                .toolbar{
                    // 添加 + 按钮
                    Button{
                        self.showingAddExpense =  true
                    }label: {
                        Image(systemName: "plus")
                        Text("添加商品")
                    }
                    Spacer()
                }
                // 创建工作表
                .sheet(isPresented: self.$showingAddExpense){
                    AddView(expenses: expenses)
                }
            }
       
        
    }
    
    
    // 删除数据方法
    func removeItems(at offsets: IndexSet)
    {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
