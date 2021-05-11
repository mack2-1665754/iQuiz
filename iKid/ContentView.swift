//
//  ContentView.swift
//  iKid
//
//  Created by stlp on 5/5/21.
//

import SwiftUI
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
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var showingAlert = false
    @EnvironmentObject var quizItemStorage: QuizItemStorage
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
                        ForEach(self.quizItemStorage.quizzes) { quizItem in
                            NavigationLink(destination: QuestionView(questions: quizItem.questions)) {
                                HStack{
                                    Image(systemName: "plus")
                                    VStack(alignment: .leading){
                                        Text(quizItem.topic)
                                        Text(quizItem.description).font(.subheadline).fontWeight(.light)
                                    }
                                }
                            }
                        }
                    
                }
            }
        }.frame(width: UIScreen.main.bounds.width-20, alignment: .center).onRotate { newOrientation in
            orientation = newOrientation
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(QuizItemStorage())
    }
}
