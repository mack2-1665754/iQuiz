//
//  DadJokes.swift
//  iKid
//
//  Created by stlp on 5/5/21.
//

import SwiftUI


struct DadJokes: View {
    @EnvironmentObject var jokeItemStorage: JokeItemStorage
    @State var jokeNum = 0
    var jokeSection: [JokeItem]
    
    init(_ jokeSection: [JokeItem]) {
        self.jokeSection = jokeSection
    }
    
    var body: some View {

        VStack {
            Text(self.jokeSection[self.jokeNum].question).padding()
            Text(self.jokeSection[self.jokeNum].answer).padding()
            
            Button(action: {
                if jokeNum < self.jokeSection.count - 1 {
                    self.jokeNum += 1
                } else {
                    self.jokeNum = 0
                }
            }) {
                Text("Next Joke").padding()
            }
        }
    }
}

struct DadJokes_Previews: PreviewProvider {
    static var previews: some View {
        DadJokes([JokeItem(question: "prev question", answer: "prev answer"), JokeItem(question: "prev question 2", answer: "prev answer 2")]).environmentObject(JokeItemStorage())
    }
}
