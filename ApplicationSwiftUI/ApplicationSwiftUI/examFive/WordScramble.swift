//
//  WordScramble.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/10/27.
//

import SwiftUI

struct WordScramble: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        
        // 创建导航栏视图
        NavigationView{
            // 创建列表视图
            List{
                // 创建分组内容视图
                Section{
                    // 创建 可编辑文本框
                    TextField("请输入您的文字", text: self.$newWord)
                    // 设置自动大写 .one 不自动大写 .allCharacters 全部自动大写 .words 开头自动大写  .sentences 开头自动大写
                        .autocapitalization(.none)
                }
                // 创建分组内容视图
                Section{
                    ForEach(usedWords,id: \.self){ word in
                        // 创建水平堆栈视图
                        HStack{
                            Text(word)
                            Spacer()
                            // 创建图片视图
                            Image(systemName: "\(word.count).circle")
                            
                        }
                    }
                    
                }
            }
            // 设置导航栏标题
            .navigationTitle(rootWord)
            .onSubmit{
                addNewWord()
            }
            .onAppear{
                startGame()
            }
            // 展示提示框
            .alert(errorTitle, isPresented: self.$showingError){
                Button("OK",role: .cancel){}
            }message: {
                Text(errorMessage)
            }
        }
    }
    
    
    
    func addNewWord(){
        // 小写newWord并删除任何空格  trimmingCharacters(in:)它要求Swift从字符串的开头和结尾删除某些类型的字符
        print("新的单词 》〉》〉》  \(newWord)")
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        print("小写 去除空格换行后的单词  \(answer)")
        // 检查它至少有1个字符，否则退出
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer)else{
            wordError(title: "单词已使用", message: "更具原创性！")
            return
        }
        
        guard isPossible(word: answer)else{
            wordError(title: "单词不可以", message: "你不能拼写那个单词  \(rootWord) !")
            return
        }
        
        guard isReal(word: answer)else{
            wordError(title: "无法识别单词", message: "你不能只是编出来，你知道！")
            return
        }
        
        withAnimation{
            // 在usedWords数组的0位置插入该单词
            usedWords.insert(answer, at: 0)
        }
        
        
        // 将newWord设置为空字符串 清空可编辑文本框
        newWord = ""
    }
    
    func startGame(){
        print("开始🎮")
        // 读取主应用程序包中文件的URL，我们使用Bundle.main.url()
        if let startWordsURL =  Bundle.main.url(forResource: "start", withExtension: "txt"){
            print("获取的文件路径》〉》〉》〉 \(startWordsURL)")
            if let startWords = try? String(contentsOf: startWordsURL){
                print("获取文件的内容》〉》〉》  \(startWords)")
                // Swift为我们提供了一种名为components(separatedBy:)的方法，该方法可以通过在发现其他字符串的地方将其拆分来将单个字符串转换为字符串数组。类似 java中的字符串分割 split
                let allWords = startWords.components(separatedBy: "\n")
                print("全部单词    \(allWords)")
                // Swift为我们提供了一个有用的其他选项：randomElement()方法从数组中返回一个随机项。
                rootWord = allWords.randomElement() ?? "silkworm"
                print("随机项  \(rootWord)")
                return
            }
        }
        
        fatalError("无法从bundle中加载start.txt")
    }
    
    func isOriginal(word: String) ->Bool
    {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) ->Bool
    {
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else
            {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) ->Bool{
        // 创建一个要检查的单词和一个可用于检查该字符串的UITextChecker实例
        let checker = UITextChecker()
        print("UITextChecker实例   \(checker)")
        let nsRange = NSRange(location: 0, length: word.utf16.count)
        print("NSRange:   \(nsRange)")
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: nsRange, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String,message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct WordScramble_Previews: PreviewProvider {
    static var previews: some View {
        WordScramble()
    }
}
