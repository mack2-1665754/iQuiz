//
//  ContentView.swift
//  DataLoading
//
//  Created by stlp on 5/18/21.
//

import SwiftUI
import Network

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct ContentView: View {
    @State var quizURL = "https://tednewardsandbox.site44.com/questions.json"
    @State var answer: String = ""
    @State var quizzes: [QuizObject] = []
    @State var showError = false
    @State var fetchError = ""
    @EnvironmentObject var quizItemStorage: QuizItemStorage
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var showingSettings = false
    @State private var network = true
    

    
    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
                List {
                    if (!self.network) {
                        Text("internet connection not available, using local data")
                    }
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
            }.alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text("Error fetching data at that location, using default quiz data"), dismissButton: .default(Text("Ok")))
            }
            .navigationTitle("iQuiz")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("settings") {
                        self.showingSettings = !self.showingSettings
                    }
                }
            }.popover(isPresented: $showingSettings) {
                VStack {
                    Text("URL to fetch quiz questions from:").padding()
                    TextField("Enter URL here:", text: $quizURL).padding()
                    Button("Check now") {
                        loadData()
                        self.showingSettings = false
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
                    self.network = true
                    loadData()
                } else {
                    print("not connected")
                    self.network = false
                    self.quizzes = quizItemStorage.quizzes
                }
            }

            let queue = DispatchQueue(label: "Monitor")
            monitor.start(queue: queue)
        }
    }
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
            if (error != nil) {
                    self.showError = true
            }
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([QuizObject].self, from: data)
                    DispatchQueue.main.async {
                        self.quizzes = decodedResponse
                        UserDefaults.standard.set(data, forKey: "quizData")
                    }
                } catch DecodingError.keyNotFound(let key, let context) {
                    self.fetchError = "could not find key \(key): \(context.debugDescription)"
                    self.showError = true
                    print(self.fetchError)
                } catch DecodingError.valueNotFound(let type, let context) {
                    self.fetchError = "could not find type \(type): \(context.debugDescription)"
                    self.showError = true
//                    print(self.fetchError)
                    print(String(self.showError))

                } catch DecodingError.dataCorrupted(let context) {
                    self.fetchError = "data corrupted: \(context.debugDescription)"
                    self.showError = true
//                    print(self.fetchError)
                    print(String(self.showError))

                } catch DecodingError.typeMismatch(let type, let context) {
                    self.fetchError = "type mismatch for type \(type) \(context.debugDescription)"
                    self.showError = true
//                    print(self.fetchError)
                    print(String(self.showError))

                } catch let error as NSError {
                    self.fetchError = "\(error.localizedDescription)"
                    self.showError = true
//                    print(self.fetchError)
                    print(String(self.showError))

                }
            }
        }.resume()
    }
}

