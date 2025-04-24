import SwiftUI

struct QuizGameEndView: View {
    @Environment(\.dismiss) var dismiss
    var onRestart: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("QuizBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {

                Text("Thanks for playing! We hope you were inspired and had a great time!")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .padding()

             

                Button(action: {
                    onRestart()
                }) {
                    Text("Try again")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(30)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }

            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .padding()
            }
            .padding(.top, 50)
            .padding(.leading)
        }
        .navigationBarHidden(true)
    }
}
