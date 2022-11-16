//
//  LanguageView.swift
//  ApplicationSwiftUI
//
//  Created by 刘奇 on 2022/11/15.
//

import SwiftUI

struct LanguageView: View {
    @State private var identifier: String = "en"
    var body: some View {
        VStack{
            Button("French", action: {
                  self.identifier = "fr"
              })
              Button("English", action: {
                  self.identifier = "en"
              })
              Text("Test")
              Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .environment(\.locale,.init(identifier: identifier))
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView()
    }
}
