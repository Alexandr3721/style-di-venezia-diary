import SwiftUI

struct MainAppView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case 0: MapView()
                case 1: WishlistView()
                case 2: ArticlesView()
                case 3: QuizView()
                default: MapView()
                }
            }

            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
