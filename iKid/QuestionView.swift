//
//  QuestionView.swift
//  iKid
//
//  Created by stlp on 5/6/21.
//

import SwiftUI

struct QuestionView: View {
    var questions = [questionItem]()
    @State var selectedQuestion = UUID()
    @State var numCorrect = 0
    @State var currentQuestion = 0
    init(questions: [questionItem]) {
        self.questions = questions
    }
    
    
    var body: some View {
        if (self.currentQuestion < questions.count) {
            VStack {
                Text("Question number " + String(self.currentQuestion + 1) + " out of " + String(questions.count))
                Text(self.questions[self.currentQuestion].questionString).font(.largeTitle).padding()
                ForEach(self.questions[self.currentQuestion].answers) { answer in
                    Button(action: {
                        //change color
                        //update the selected correct question (so a user can change their answer)
                        self.selectedQuestion = answer.id
                    }) {
                        // if answer.id = self.selectedQuestion
                        if (answer.id == self.selectedQuestion){
                            Text(answer.answerString).padding()
                                .foregroundColor(.white)
                                .background(Rectangle().cornerRadius(25).frame(width: 200, height: 50).foregroundColor(.green))
                        } else {
                            Text(answer.answerString).padding()
                                .foregroundColor(.white).frame(width: 200, height: 50)
                                .background(Rectangle().cornerRadius(25))
                        }
                    }
                }
                Button(action: {
                    let questionAnswers = questions[self.currentQuestion].answers
                    for i in 0...questionAnswers.count - 1 {
                        if (questionAnswers[i].id == self.selectedQuestion) {
                            if (questionAnswers[i].isCorrect) {
                                self.numCorrect += 1
                            }
                        }
                    }
                    
                    if (self.currentQuestion < questions.count) {
                        self.currentQuestion += 1
                    }
                }) {
                    Text("Submit Answer").padding()
                        .foregroundColor(.white)
                        .background(Rectangle().cornerRadius(25)).padding()
                        
                    
                }
            }
        } else {
            let score = Double(self.numCorrect) / Double(self.questions.count)
            VStack {
                Text("Quiz finished").font(.largeTitle)
                if (score == 1.0) {
                    Text("Perfect score!").padding()
                } else {
                    Text("Study more next time :(").padding()
                }
                Text("You correctly answered " + String(self.numCorrect))
                Text("out of " + String(self.questions.count) + " questions correct")
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(questions: [questionItem(questionString: "My test qiestion", answers: [answerItem(answerString: "answer1", isCorrect: true), answerItem(answerString: "answer2", isCorrect: false)]), questionItem(questionString: "My test qiestion2", answers: [answerItem(answerString: "answer1", isCorrect: true), answerItem(answerString: "answer2", isCorrect: false)])])
    }
}
