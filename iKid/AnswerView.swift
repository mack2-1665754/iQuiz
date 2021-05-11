//
//  AnswerView.swift
//  iKid
//
//  Created by stlp on 5/11/21.
//

import SwiftUI

struct AnswerView: View {
    var answerString: String
    @State var selected: Bool = false
    
    init(answerString: String) {
        self.answerString = answerString
    }
    
    var body: some View {
        Button(action: {
            self.selected = !self.selected
            print(self.selected)
        }) {
            if (self.selected) {
                Text(answerString).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            } else {
                Text(answerString).foregroundColor(.green)
            }
        }
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(answerString: "answer")
    }
}
