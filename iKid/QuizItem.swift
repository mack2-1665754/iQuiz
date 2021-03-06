//
//  JokeItem.swift
//  iKid
//
//  Created by stlp on 5/5/21.
//

import Foundation

struct QuizObject: Identifiable {
    var id = UUID()
    var topic: String
    var description: String
    var questions: [questionItem] = []
    
    init(topic: String, description: String, questions: [questionItem]) {
        self.topic = topic
        self.description = description
        self.questions = questions
    }
}

struct questionItem {
    var questionString: String
    var answers: [answerItem]
    
    init(questionString: String, answers: [answerItem]) {
        self.questionString = questionString
        self.answers = answers
    }
}

struct answerItem: Identifiable {
    var id = UUID()
    var answerString: String
    var isCorrect: Bool
    
    init(answerString: String, isCorrect: Bool){
        self.answerString = answerString
        self.isCorrect = isCorrect
    }
}

class QuizItemStorage: ObservableObject {
    @Published var quizzes = [QuizObject(topic: "Math", description: "Math questions",
                                            questions: [questionItem(questionString: "2+2=",
                                                                     answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "22", isCorrect: false), answerItem(answerString: "3", isCorrect: false)]),
                                                        questionItem(questionString: "2*2=",
                                                                     answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "44", isCorrect: false), answerItem(answerString: "22", isCorrect: false)]),
                                                        questionItem(questionString: "2*3=",
                                                                     answers: [answerItem(answerString: "6", isCorrect: true), answerItem(answerString: "23", isCorrect: false), answerItem(answerString: "66", isCorrect: false)])]),
                              QuizObject(topic: "Science", description: "Science questions",
                                                                      questions: [questionItem(questionString: "What is the most dense form of matter?",
                                                                                               answers: [answerItem(answerString: "Solid", isCorrect: true), answerItem(answerString: "Liquid", isCorrect: false), answerItem(answerString: "Gas", isCorrect: false)]),
                                                                                  questionItem(questionString: "What chemical formula is represented by the formula NaCl?",
                                                                                               answers: [answerItem(answerString: "Sodium Chloride", isCorrect: true), answerItem(answerString: "Sodium", isCorrect: false), answerItem(answerString: "Hydrogen Chloride", isCorrect: false)]),
                                                                                  questionItem(questionString: "A person would weigh more on earth than on the moon.",
                                                                                               answers: [answerItem(answerString: "True", isCorrect: true), answerItem(answerString: "False", isCorrect: false)])]),
                              QuizObject(topic: "Random", description: "Random questions",
                                                                      questions: [questionItem(questionString: "What is the complementary color to blue?",
                                                                                               answers: [answerItem(answerString: "orange", isCorrect: true), answerItem(answerString: "yellow", isCorrect: false), answerItem(answerString: "green", isCorrect: false)]),
                                                                                  questionItem(questionString: "The first person convicted of speeding was going",
                                                                                               answers: [answerItem(answerString: "8mph", isCorrect: true), answerItem(answerString: "30mph", isCorrect: false), answerItem(answerString: "100mph", isCorrect: false)]),
                                                                                  questionItem(questionString: "What countries has the most spoken languages in the world?",
                                                                                               answers: [answerItem(answerString: "Papua New Guinea", isCorrect: true), answerItem(answerString: "Spain", isCorrect: false), answerItem(answerString: "France", isCorrect: false)])])]
}
