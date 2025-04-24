import SwiftUI

struct OutfitDetail: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var favoritesManager: FavoritesManager

    let outfit: Outfit

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()

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

                    Text("Info")
                        .foregroundColor(.white)
                        .font(.headline)

                    Spacer()

                    Button(action: {
                        favoritesManager.toggleFavorite(outfit)
                    }) {
                        Image(systemName: favoritesManager.isFavorite(outfit) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .imageScale(.medium)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 50)
                .padding(.bottom, 10)
                .background(Color(red: 0.14, green: 0.14, blue: 0.14))

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        outfitImage()

                        Text(outfit.title)
                            .font(.title2).bold()
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        Group {
                            TagSection(title: "Tags:", tags: outfit.tags)
                        }
                        .padding(.horizontal)

                        Text("Use:")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(outfit.usedImages, id: \.self) { img in
                                    Image(img)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }

                        Spacer(minLength: 40)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100) 
                }
            }
        }
        .navigationBarHidden(true)
    }

    @ViewBuilder
    private func outfitImage() -> some View {
        if let uiImage = loadImage(named: outfit.imageName) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .cornerRadius(20)
                .padding(.horizontal)
        } else {
            Image(outfit.imageName)
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .cornerRadius(20)
                .padding(.horizontal)
        }
    }

    private func loadImage(named name: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(name)
        return UIImage(contentsOfFile: url.path)
    }
} 
