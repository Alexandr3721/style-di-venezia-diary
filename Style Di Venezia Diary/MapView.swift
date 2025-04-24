import SwiftUI

struct MapView: View {
    @State private var showFavorites = false
    @State private var showAddCard = false
    @State private var showSettings = false

    @EnvironmentObject var favoritesManager: FavoritesManager

    @State private var outfits: [Outfit] = [
        Outfit(id: UUID(), imageName: "look1", title: "Spring Dawn", tags: ["Spring", "Classic", "Hourglass", "Romantic"], usedImages: ["used1a", "used1b", "used1c"]),
        Outfit(id: UUID(), imageName: "look2", title: "Winter grunge style", tags: ["Winter", "Athleisure", "Grunge", "Pear"], usedImages: ["used2a", "used2b", "used2c"]),
        Outfit(id: UUID(), imageName: "look3", title: "Autumn coziness", tags: ["Fall", "Classic", "Rectangle"], usedImages: ["used3a", "used3b", "used3c"]),
        Outfit(id: UUID(), imageName: "look4", title: "Minimalism in action", tags: ["Summer", "Boho", "Pear"], usedImages: ["used4a", "used4b", "used4c"])
    ]

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(outfits) { outfit in
                            OutfitCardView(outfit: outfit)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 180)
                }

                VStack(spacing: 16) {
                    CircleButton(imageName: "plus", backgroundColor: .yellow) {
                        showAddCard = true
                    }

                    CircleButton(imageName: "heart.fill", backgroundColor: .red) {
                        showFavorites = true
                    }
                }
                .padding(.trailing, 16)
                .padding(.bottom, 110)

                NavigationLink(
                    destination: FavoritesView().environmentObject(favoritesManager),
                    isActive: $showFavorites
                ) {
                    EmptyView()
                }
                .hidden()

                NavigationLink(
                    destination: SettingsView(),
                    isActive: $showSettings
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .background(Color.black)
            .navigationTitle("Looks & Outfits")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button(action: {
                    showSettings = true 
                }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.white)
                }
            )
            .sheet(isPresented: $showAddCard) {
                if #available(iOS 16.0, *) {
                    AddOutfitView { newOutfit in
                        outfits.append(newOutfit)
                    }
                }
            }
        }
    }
}
