import SwiftUI

struct QuizGameEndView: View {
    @Environment(\.dismiss) var dismiss
    var onRestart: () -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
           
                Image("QuizBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: geo.size.height * 0.04) {
                    Spacer()

                    Text("Thanks for playing!\nWe hope you were inspired and had a great time!")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .font(.system(size: geo.size.width * 0.05, weight: .semibold))
                        .padding()
                        .background(Color.yellow.opacity(0.9))
                        .cornerRadius(16)
                        .padding(.horizontal)

                    Button(action: {
                        onRestart()
                    }) {
                        Text("Try again")
                            .font(.system(size: geo.size.width * 0.045, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow.opacity(0.9))
                            .cornerRadius(25)
                            .shadow(radius: 4)
                    }
                    .padding(.horizontal)

                    Spacer()
                }

                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .imageScale(.large)
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.top, geo.safeAreaInsets.top + 10)
                .padding(.leading)
            }
        }
        .navigationBarHidden(true)
    }
}
