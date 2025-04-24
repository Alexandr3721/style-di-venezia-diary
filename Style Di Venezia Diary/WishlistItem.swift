import SwiftUI
import PhotosUI

struct WishlistItem: Identifiable, Codable {
    var id: UUID
    var title: String
    var price: String
    var category: String
    var imageData: Data?
    var bought: Bool

    var image: UIImage? {
        imageData.flatMap { UIImage(data: $0) }
    }
}

class WishlistManager: ObservableObject {
    @Published var items: [WishlistItem] = [] {
        didSet {
            saveItems()
        }
    }

    private let saveKey = "wishlist_items"

    init() {
        loadItems()
    }

    func addItem(_ item: WishlistItem) {
        items.append(item)
    }

    private func saveItems() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let saved = try? JSONDecoder().decode([WishlistItem].self, from: data) {
            self.items = saved
        }
    }
}

struct WishlistView: View {
    @EnvironmentObject var manager: WishlistManager
    @State private var showAddSheet = false
    @State private var showFilterSheet = false
    @State private var filterCategory: String = ""
    @State private var showBought = false

    var filteredItems: [WishlistItem] {
        manager.items.filter { item in
            (filterCategory.isEmpty || item.category == filterCategory) && item.bought == showBought
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                
                    HStack(spacing: 0) {
                        Button(action: { showBought = false }) {
                            Text("I want to buy")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(showBought ? Color.clear : Color(.darkGray))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                        Button(action: { showBought = true }) {
                            Text("Bought")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(showBought ? Color(.darkGray) : Color.clear)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                    .padding()

                    if filteredItems.isEmpty {
                        Spacer()
                        Text("Wishlist is empty, add your desired purchase now")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(filteredItems) { item in
                                    WishlistCardView(item: item)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 100) 
                        }
                    }
                }
                .background(Color.black.ignoresSafeArea())

                VStack(spacing: 16) {
                    CircleButton(imageName: "plus", backgroundColor: .yellow) {
                        showAddSheet = true
                    }
                    CircleButton(imageName: "line.horizontal.3.decrease", backgroundColor: .gray) {
                        showFilterSheet = true
                    }
                }
                .padding(.trailing, 16)
                .padding(.bottom, 110)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Wishlist")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddWishlistItemView { newItem in
                    manager.addItem(newItem)
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterView(selectedCategory: $filterCategory)
            }
        }
    }
}

