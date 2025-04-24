import SwiftUI

struct OutfitCardView: View {
    let outfit: Outfit
    var hasButtons: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            outfitImage()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(12)

            Text(outfit.title)
                .font(.headline)
                .foregroundColor(.white)

            HStack {
                ForEach(outfit.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }

            NavigationLink(destination: OutfitDetail(outfit: outfit)) {
                Text("Read more")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .foregroundColor(.black)
                    .cornerRadius(12)
            }

            if hasButtons {
                HStack {
                    Spacer()
                    CircleButton(imageName: "plus", backgroundColor: .yellow)
                    CircleButton(imageName: "line.horizontal.3.decrease", backgroundColor: .gray)
                    CircleButton(imageName: "heart.fill", backgroundColor: .red)
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(16)
    }

    @ViewBuilder
    private func outfitImage() -> some View {
        if let uiImage = loadImage(named: outfit.imageName) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image(outfit.imageName)
                .resizable()
        }
    }

    private func loadImage(named name: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(name)
        return UIImage(contentsOfFile: url.path)
    }
}
