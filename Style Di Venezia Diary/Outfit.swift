import Foundation

struct Outfit: Identifiable, Codable, Equatable {
    let id: UUID
    let imageName: String
    let title: String
    let tags: [String]
    let usedImages: [String]
}

import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [Outfit] = []

    private let key = "favoriteOutfits"

    init() {
        loadFavorites()
    }

    func isFavorite(_ outfit: Outfit) -> Bool {
        favorites.contains(outfit)
    }

    func toggleFavorite(_ outfit: Outfit) {
        if isFavorite(outfit) {
            favorites.removeAll { $0 == outfit }
        } else {
            favorites.append(outfit)
        }
        saveFavorites()
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Outfit].self, from: data) {
            favorites = decoded
        }
    }
}

