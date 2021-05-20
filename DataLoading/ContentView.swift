//
//  ContentView.swift
//  DataLoading
//
//  Created by stlp on 5/18/21.
//

import SwiftUI
import Network



struct ContentView: View {
    @State var quizURL = "https://tednewardsandbox.site44.com/questions.json"
    @State var answer: String = ""
    @State var quizzes: [QuizObject] = []
    @State var showError = false
    @State var loadError = ""
    @EnvironmentObject var quizItemStorage: QuizItemStorage
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var showingAlert = false
//    @State var quizURL = "https://tednewardsandbox.site44.com/questions.json"
//    @State var answer: String = ""
//    @State var quizzes: [QuizObject] = []
//    @State var showError = false
//    @State var loadError = ""
//    @EnvironmentObject var quizItemStorage: QuizItemStorage
    

    
    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {

                Button("Settings") {
                    showingAlert = true
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Settings"), message: Text("Settings go here"), dismissButton: .default(Text("Ok")))
                }
                List {
                        ForEach(self.quizzes) { quiz in
                            NavigationLink(destination: QuestionView(questions: quiz.questions)) {
                                HStack{
                                    Image(systemName: "plus")
                                    VStack(alignment: .leading){
                                        Text(quiz.title)
                                        Text(quiz.desc).font(.subheadline).fontWeight(.light)
                                    }
                                }
                            }
                        }
                    
                }
            }
        }.onAppear {
            let monitor = NWPathMonitor()

            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    print("connected")
                    loadData()
                } else {
                    print("not connected")
                    self.quizzes = quizItemStorage.quizzes
                }
            }

            let queue = DispatchQueue(label: "Monitor")
            monitor.start(queue: queue)
        }
//        .frame(width: UIScreen.main.bounds.width-20, alignment: .center).onRotate { newOrientation in
//            orientation = newOrientation
//        }
    }
//    var body: some View {
//        VStack {
//            ForEach(self.quizzes) { quiz in
//                VStack {
//                Text(quiz.title)
//                    ForEach(quiz.questions) { question in
//                        Text(question.text)
//                        ForEach(question.answers, id: \.self) { answer in
//                            Text(answer)
//                        }
//                    }
//                }
//            }
//            Text("Quiz")
//                .padding()
//        }.onAppear {
//            self.quizzes = []
//            let monitor = NWPathMonitor()
//
//            monitor.pathUpdateHandler = { path in
//                if path.status == .satisfied {
//                    print("connected")
//                    loadData()
//
//                } else {
//                    print("not connected")
//                    self.quizzes = quizItemStorage.quizzes
//                }
//            }
//
//            let queue = DispatchQueue(label: "Monitor")
//            monitor.start(queue: queue)
//        }
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView().environmentObject(QuizItemStorage())
    }
}

extension ContentView {
    func loadData() -> Void {
        print("load data called")
        guard let url = URL(string: quizURL) else {
            print("Invalid URL")
            return
        }
        print("quiz url" + quizURL)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([QuizObject].self, from: data)
                    DispatchQueue.main.async {
                        self.quizzes = decodedResponse
                        UserDefaults.standard.set(data, forKey: "quizData")
//                        print(String(quizzes[0].title))
                    }
                } catch DecodingError.keyNotFound(let key, let context) {
                    self.loadError = "could not find key \(key) in JSON: \(context.debugDescription)"
                    print(self.loadError)
                } catch DecodingError.valueNotFound(let type, let context) {
                    self.loadError = "could not find type \(type) in JSON: \(context.debugDescription)"
                    print(self.loadError)
                } catch DecodingError.typeMismatch(let type, let context) {
                    self.loadError = "type mismatch for type \(type) in JSON: \(context.debugDescription)"
                    print(self.loadError)
                } catch DecodingError.dataCorrupted(let context) {
                    self.loadError = "data found to be corrupted in JSON: \(context.debugDescription)"
                    print(self.loadError)
                } catch let error as NSError {
                    self.loadError = "Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)"
                    print(self.loadError)
                }
            }
        }.resume()
    }
}

//struct ContentView: View {
//    @State private var orientation = UIDeviceOrientation.unknown
//    @State private var showingAlert = false
//    @State var quizURL = "https://tednewardsandbox.site44.com/questions.json"
//    @State var answer: String = ""
//    @State var quizzes: [QuizObject] = []
//    @State var showError = false
//    @State var loadError = ""
//    @EnvironmentObject var quizItemStorage: QuizItemStorage
//    
//
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .trailing) {
//
//                
//                Button("Settings") {
//                    showingAlert = true
//                }
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("Settings"), message: Text("Settings go here"), dismissButton: .default(Text("Ok")))
//                }
//                List {
//                        ForEach(self.quizItemStorage.quizzes) { quizItem in
//                            NavigationLink(destination: QuestionView(questions: quizItem.questions)) {
//                                HStack{
//                                    Image(systemName: "plus")
//                                    VStack(alignment: .leading){
//                                        Text(quizItem.topic)
//                                        Text(quizItem.description).font(.subheadline).fontWeight(.light)
//                                    }
//                                }
//                            }
//                        }
//                    
//                }
//            }
//        }.frame(width: UIScreen.main.bounds.width-20, alignment: .center).onRotate { newOrientation in
//            orientation = newOrientation
//        }
//    }
//    
//}
