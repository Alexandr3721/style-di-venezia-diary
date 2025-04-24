import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    let activeIcons = ["map_active", "favorites_active", "articles_active", "quiz_active"]
    let inactiveIcons = ["map_inactive", "favorites_inactive", "articles_inactive", "quiz_inactive"]
    let titles = ["Looks & Outfits", "Wishlist", "Articles", "Quiz"]

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                ForEach(0..<4) { index in
                    Spacer()

                    Button(action: {
                        selectedTab = index
                    }) {
                        VStack(spacing: 6) {
                            ZStack {
                                if selectedTab == index {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color(red: 0.22, green: 0.22, blue: 0.22))
                                        .frame(width: 60, height: 44)
                                }

                                Image(selectedTab == index ? activeIcons[index] : inactiveIcons[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                            }

                            Text(titles[index])
                                .font(.caption)
                                .foregroundColor(selectedTab == index ? .yellow : .white)
                        }
                    }

                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 6)
            .background(Color(red: 0.14, green: 0.14, blue: 0.14))

            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .frame(width: 80, height: 4)
                .padding(.bottom, 6)
        }
    }
}
