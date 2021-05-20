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
    @State var fetchError = ""
    @EnvironmentObject var quizItemStorage: QuizItemStorage
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var showingAlert = false

    

    
    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
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
            }.navigationTitle("iQuiz")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("settings") {
                        self.showingAlert = !self.showingAlert
                    }
                }
            }.popover(isPresented: $showingAlert) {
                VStack {
                    Text("URL to fetch quiz questions from:").padding()
                    TextField("Enter URL here:", text: $quizURL).padding()
                    Button("Check now") {
                        loadData()
                        self.showingAlert = false
                    }.padding()
                    .foregroundColor(.white).frame(width: 200, height: 50)
                    .background(Rectangle().cornerRadius(25).foregroundColor(.green))
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
                    self.fetchError = "could not find key \(key): \(context.debugDescription)"
                    print(self.fetchError)
                } catch DecodingError.valueNotFound(let type, let context) {
                    self.fetchError = "could not find type \(type): \(context.debugDescription)"
                    print(self.fetchError)
                } catch DecodingError.dataCorrupted(let context) {
                    self.fetchError = "data corrupted: \(context.debugDescription)"
                    print(self.fetchError)
                } catch DecodingError.typeMismatch(let type, let context) {
                    self.fetchError = "type mismatch for type \(type) \(context.debugDescription)"
                    print(self.fetchError)
                } catch let error as NSError {
                    self.fetchError = "\(error.localizedDescription)"
                    print(self.fetchError)
                }
            }
        }.resume()
    }
}

