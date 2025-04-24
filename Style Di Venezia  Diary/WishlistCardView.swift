import SwiftUI
import PhotosUI

struct WishlistCardView: View {
    let item: WishlistItem
    @State private var showDetail = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let img = item.image {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
            }

            HStack {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("$\(item.price)")
                    .foregroundColor(.white)
                    .bold()
            }

            Text(item.category)
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(12)

            Button("Read more") {
                showDetail = true
            }
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

            NavigationLink(destination: WishlistDetailView(item: item), isActive: $showDetail) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(16)
    }
}
