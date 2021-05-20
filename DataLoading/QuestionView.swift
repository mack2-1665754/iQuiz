//
//  QuestionView.swift
//  DataLoading
//
//  Created by stlp on 5/19/21.
//

import SwiftUI

struct QuestionView: View {
    var questions = [Question]()
    @State var selectedAnswer : String = ""
    @State var answerIsCorrect = true
    @State var numCorrect = 0
    @State var currentQuestion = 0
    @State var submitted = false
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    var drag : some Gesture {
        DragGesture().onEnded {_ in
                if (self.currentQuestion < questions.count) {
                    self.currentQuestion += 1
                    self.answerIsCorrect = true
                }
            }
    }
    
    func checkAnswer() {
        print("answer checked")
        let questionAnswers = self.questions[self.currentQuestion].answers
        let answerIndex = Int(self.questions[self.currentQuestion].answer)
        
        if (self.selectedAnswer == questionAnswers[answerIndex! - 1]) {
            //is correct
            print("correct answer")
            self.numCorrect += 1
            self.answerIsCorrect = true
        } else {
            //is incorrect
            print("incorrect answer")
            self.answerIsCorrect = false
        }
    }
    
    
    
    var body: some View {
        if (self.currentQuestion < questions.count) {
            VStack {
                let questionObj = self.questions[self.currentQuestion]
                Text("Question number " + String(self.currentQuestion + 1))
                Text(questionObj.text).padding()
                
                // find this in button
//                let answersIndex = Int(questionObj.answer)
                
                ForEach(questionObj.answers, id: \.self) { answer in
                    Button(action: {
                        self.selectedAnswer = answer
                    }) {

                        if (answer == self.selectedAnswer){
                            Text(answer).padding()
                                .foregroundColor(.white)
                                .background(Rectangle().cornerRadius(25).foregroundColor(.green))
                        } else {
                            Text(answer).padding()
                                .foregroundColor(.white)
                                .background(Rectangle().cornerRadius(25))
                        }
                    }
                }
                
                Spacer()
                Button(action: {
                    checkAnswer()
                    
                }) {
                    Text("Submit Answer").padding()
                        .foregroundColor(.white)
                        .background(Rectangle().cornerRadius(25).frame(width: 150, height: 50).padding())

                }
                
                if (!self.answerIsCorrect) {
                    Text("wrong answer")
                }
//
                Text("Swipe here for next question").padding().gesture(drag)
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
        QuestionView(questions: [Question(text: "question",
                                          answer: "1",
                                          answers: ["answer", "correct answer"])])
    }
}
