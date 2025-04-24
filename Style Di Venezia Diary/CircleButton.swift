import SwiftUI

struct CircleButton: View {
    let imageName: String
    let backgroundColor: Color
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .foregroundColor(.white)
                .padding(20)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}
