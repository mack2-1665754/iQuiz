//
//  JokeItem.swift
//  iKid
//
//  Created by stlp on 5/5/21.
//

import Foundation

struct JokeItem: Identifiable {
    var id = UUID()
    
    var question: String
    var answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}


class JokeItemStorage: ObservableObject {
    //published makes it so we can access the data throughout the app
    @Published var dadJokes = [JokeItem(question: "What do you call 26 letters that went for a swim?", answer: "Alphaweitcal"), JokeItem(question: "What kind of shoes does a lazy person wear?", answer: "Loafers"), JokeItem(question: "What is a chiropractors favorite kind of music?", answer: "Hip hop")]
    @Published var punJokes = [JokeItem(question: "What do you call an aligator in a vest?", answer: "An Investigator"), JokeItem(question: "What do you call a dog that can do magic tricks?", answer: "A labracadabrador"), JokeItem(question: "What do you call a performance on puns?", answer: "A play on words")]
    @Published var goodJokes = [JokeItem(question: "What do you call a boomerang that won't come back?", answer: "A stick"), JokeItem(question: "Why can't your nose be 12 inches long?", answer: "Then it would be a foot"), JokeItem(question: "How does the moon cut his hair?", answer: "Eclipse it")]

}
