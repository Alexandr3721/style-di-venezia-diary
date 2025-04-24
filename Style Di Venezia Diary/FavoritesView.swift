import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
      
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                }

                Spacer()

                Text("Favorites")
                    .foregroundColor(.white)
                    .font(.headline)

                Spacer()

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .padding(.bottom, 10)
            .background(Color(red: 0.14, green: 0.14, blue: 0.14))

            ScrollView {
                VStack(spacing: 24) {
                    if favoritesManager.favorites.isEmpty {
                        Text("No favorites yet")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(favoritesManager.favorites) { outfit in
                            OutfitCardView(outfit: outfit)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 100) 
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
