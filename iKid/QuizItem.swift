//
//  JokeItem.swift
//  iKid
//
//  Created by stlp on 5/5/21.
//

import Foundation

struct quizQuestions: Identifiable {
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
    @Published var quizzes = [quizQuestions(topic: "Math", description: "Math questions",
                                            questions: [questionItem(questionString: "2+2=",
                                                                     answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "22", isCorrect: false), answerItem(answerString: "3", isCorrect: false)]),
                                                        questionItem(questionString: "2*2=",
                                                                     answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "44", isCorrect: false), answerItem(answerString: "22", isCorrect: false)]),
                                                        questionItem(questionString: "2*3=",
                                                                     answers: [answerItem(answerString: "6", isCorrect: true), answerItem(answerString: "23", isCorrect: false), answerItem(answerString: "66", isCorrect: false)])]),
                              quizQuestions(topic: "Science", description: "Science questions",
                                                                      questions: [questionItem(questionString: "2+2=",
                                                                                               answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "22", isCorrect: false), answerItem(answerString: "3", isCorrect: false)]),
                                                                                  questionItem(questionString: "2*2=",
                                                                                               answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "44", isCorrect: false), answerItem(answerString: "22", isCorrect: false)]),
                                                                                  questionItem(questionString: "2*3=",
                                                                                               answers: [answerItem(answerString: "6", isCorrect: true), answerItem(answerString: "23", isCorrect: false), answerItem(answerString: "66", isCorrect: false)])]),
                              quizQuestions(topic: "Random", description: "Random questions",
                                                                      questions: [questionItem(questionString: "2+2=",
                                                                                               answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "22", isCorrect: false), answerItem(answerString: "3", isCorrect: false)]),
                                                                                  questionItem(questionString: "2*2=",
                                                                                               answers: [answerItem(answerString: "4", isCorrect: true), answerItem(answerString: "44", isCorrect: false), answerItem(answerString: "22", isCorrect: false)]),
                                                                                  questionItem(questionString: "2*3=",
                                                                                               answers: [answerItem(answerString: "6", isCorrect: true), answerItem(answerString: "23", isCorrect: false), answerItem(answerString: "66", isCorrect: false)])])]
}