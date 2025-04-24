import SwiftUI

@main
struct Style_Di_Venezia_DiaryApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var favoritesManager = FavoritesManager()
    @StateObject var wishlistManager = WishlistManager()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoadingView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(favoritesManager)
            .environmentObject(wishlistManager)
        }
    }
}
