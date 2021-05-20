////
////  QuizObject.swift
////  DataLoading
////
////  Created by stlp on 5/18/21.
////
//
import Foundation

import SwiftUI

struct QuizObject: Codable, Identifiable {
    let id = UUID()
    var title: String
    var desc: String
    var questions: [Question]
}

struct Question: Codable, Identifiable {
    let id = UUID()
    var text: String
    var answer: String
    var answers: [String]
}

class QuizItemStorage: ObservableObject {
    @Published var quizzes : [QuizObject] = [QuizObject(
        title: "default",
        desc:
        "default",
        questions: [Question(text: "question",
                             answer: "1",
                             answers: ["answer", "correct answer"])]
    )]
}

