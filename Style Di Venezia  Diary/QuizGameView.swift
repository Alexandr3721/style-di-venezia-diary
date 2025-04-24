import SwiftUI

struct QuizGameView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentIndex = 0
    @State private var selectedItems: Set<Int> = []
    @State private var showPercentage = false
    @State private var matchPercentage = 0
    @State private var showEndScreen = false

    let looks: [[String]] = [
        ["look1-1", "look1-2", "look1-3", "look1-4", "look1-5", "look1-6"],
        ["look2-1", "look2-2", "look2-3", "look2-4", "look2-5", "look2-6"],
        ["look3-1", "look3-2", "look3-3", "look3-4", "look3-5", "look3-6"],
        ["look4-1", "look4-2", "look4-3", "look4-4", "look4-5", "look4-6"],
        ["look5-1", "look5-2", "look5-3", "look5-4", "look5-5", "look5-6"]
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("QuizBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                if showEndScreen {
                    QuizGameEndView {
                        currentIndex = 0
                        selectedItems.removeAll()
                        showPercentage = false
                        showEndScreen = false
                    }
                } else {
                    VStack(spacing: 10) {
                  
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .imageScale(.large)
                                    .padding()
                            }

                            Spacer()

                            Text("Look №\(currentIndex + 1)")
                                .font(.headline)
                                .foregroundColor(.white)

                            Spacer()

                            Text("\(currentIndex + 1)/5")
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .padding()
                        }

                        if showPercentage {
                            Spacer()
                            Text("This image was chosen by \(matchPercentage)% of users")
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: geo.size.width * 0.9)
                                .background(Color.yellow)
                                .cornerRadius(12)
                            Spacer()

                            Button(action: {
                                if currentIndex < looks.count - 1 {
                                    currentIndex += 1
                                    selectedItems.removeAll()
                                    showPercentage = false
                                } else {
                                    showEndScreen = true
                                }
                            }) {
                                Text("Next")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.yellow)
                                    .cornerRadius(30)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, geo.safeAreaInsets.bottom + 290)
                        } else {
                            Text("Select the photos you want to use to create an outfit")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: geo.size.width * 0.9)
                                .background(Color.yellow)
                                .cornerRadius(12)
                                .padding(.top)

                            let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(looks[currentIndex].indices, id: \.self) { index in
                                    let imageName = looks[currentIndex][index]
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: geo.size.width / 3 - 24)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(selectedItems.contains(index) ? Color.yellow : Color.clear, lineWidth: 4)
                                        )
                                        .onTapGesture {
                                            if selectedItems.contains(index) {
                                                selectedItems.remove(index)
                                            } else {
                                                selectedItems.insert(index)
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal)

                            Spacer()

                            Button(action: {
                                matchPercentage = Int.random(in: 70...90)
                                showPercentage = true
                            }) {
                                Text("Collect")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.yellow)
                                    .cornerRadius(30)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, geo.safeAreaInsets.bottom + 290)
                            .disabled(selectedItems.isEmpty)

                        }
                    }
                    .padding(.bottom, geo.safeAreaInsets.bottom) 
                }
            }
        }
        .navigationBarHidden(true)
    }
}
