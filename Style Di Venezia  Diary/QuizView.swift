import SwiftUI

struct QuizView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("Quiz")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    NavigationLink(destination: QuizGameView()) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 100, height: 100)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.yellow, .orange]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 290)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("") 
        }
    }
}
