import SwiftUI

struct WishlistDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: WishlistManager

    let item: WishlistItem

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

                Text("Details")
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
                VStack(alignment: .leading, spacing: 20) {
                    if let img = item.image {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                            .padding(.bottom)
                    }

                    Text(item.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)

                    Text("Price: $\(item.price)")
                        .foregroundColor(.white)

                    Text("Category: \(item.category)")
                        .foregroundColor(.white)

                    Text(item.bought ? "Status: Bought" : "Status: I want to buy")
                        .foregroundColor(item.bought ? .green : .yellow)

                    if !item.bought {
                        Button(action: {
                            markAsBought()
                        }) {
                            Text("Mark as Bought")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                        }
                        .padding(.top)
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 100)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarHidden(true)
    }

    private func markAsBought() {
    
        if let index = manager.items.firstIndex(where: { $0.id == item.id }) {
            var updatedItem = manager.items[index]
            updatedItem.bought = true
            manager.items[index] = updatedItem
        }
        dismiss() 
    }
}
