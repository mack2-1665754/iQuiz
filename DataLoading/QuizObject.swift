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
    @Published var quizzes : [QuizObject] = [
        QuizObject( title:"Science!",
          desc:"Because SCIENCE!",
          questions:[
            Question(
              text:"What is fire?",
              answer:"1",
              answers:[
                "One of the four classical elements",
                "A magical reaction given to us by God",
                "A band that hasn't yet been discovered",
                "Fire! Fire! Fire! heh-heh"
              ]
            )
          ]
        ),
        QuizObject(title:"Marvel Super Heroes", desc: "Avengers, Assemble!",
          questions:[
            Question(
              text:"Who is Iron Man?",
              answer:"1",
              answers:[
                "Tony Stark",
                "Obadiah Stane",
                "A rock hit by Megadeth",
                "Nobody knows"
              ]
            ),
            Question(
              text:"Who founded the X-Men?",
              answer:"2",
              answers:[
                "Tony Stark",
                "Professor X",
                "The X-Institute",
                "Erik Lensherr"
              ]
            ),
            Question(
              text:"How did Spider-Man get his powers?",
              answer:"1",
              answers:[
                "He was bitten by a radioactive spider",
                "He ate a radioactive spider",
                "He is a radioactive spider",
                "He looked at a radioactive spider"
              ]
            )
          ]
        ),
        QuizObject( title:"Mathematics", desc:"Did you pass the third grade?",
          questions:[
             Question(
               text:"What is 2+2?",
               answer:"1",
               answers:[
                 "4",
                 "22",
                 "An irrational number",
                 "Nobody knows"
               ]
             )
          ]
       )
    ]
}

//[
//    QuizObject( title:"Science!",
//      desc:"Because SCIENCE!",
//      questions:[
//        Question(
//          text:"What is fire?",
//          answer:"1",
//          answers:[
//            "One of the four classical elements",
//            "A magical reaction given to us by God",
//            "A band that hasn't yet been discovered",
//            "Fire! Fire! Fire! heh-heh"
//          ]
//        )
//      ]
//    ),
//    QuizObject(title:"Marvel Super Heroes", desc: "Avengers, Assemble!",
//      questions:[
//        Question(
//          text:"Who is Iron Man?",
//          answer:"1",
//          answers:[
//            "Tony Stark",
//            "Obadiah Stane",
//            "A rock hit by Megadeth",
//            "Nobody knows"
//          ]
//        ),
//        Question(
//          text:"Who founded the X-Men?",
//          answer:"2",
//          answers:[
//            "Tony Stark",
//            "Professor X",
//            "The X-Institute",
//            "Erik Lensherr"
//          ]
//        ),
//        Question(
//          text:"How did Spider-Man get his powers?",
//          answer:"1",
//          answers:[
//            "He was bitten by a radioactive spider",
//            "He ate a radioactive spider",
//            "He is a radioactive spider",
//            "He looked at a radioactive spider"
//          ]
//        )
//      ]
//    ),
//    QuizObject( title:"Mathematics", desc:"Did you pass the third grade?",
//      questions:[
//         Question(
//           text:"What is 2+2?",
//           answer:"1",
//           answers:[
//             "4",
//             "22",
//             "An irrational number",
//             "Nobody knows"
//           ]
//         )
//      ]
//   )
//]
