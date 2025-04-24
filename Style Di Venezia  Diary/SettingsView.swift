import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
          
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .imageScale(.large)
                            .padding(.leading)
                    }

                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.headline)

                    Spacer()
                }
                .padding(.vertical, 12)
                .background(Color.black)

                List {
                    Link(destination: URL(string: "https://landing.flycricket.io/style-di-venezia-diary/b1625a15-0b31-4221-9e99-8b841652b674/?t=1745438674")!) {
                        Label("Terms of Use", systemImage: "doc.text")
                            .foregroundColor(.white)
                    }

                    Link(destination: URL(string: "https://www.termsfeed.com/live/25793448-b8ec-42c5-b5c7-511c9774d6b9")!) {
                        Label("Privacy Policy", systemImage: "shield")
                            .foregroundColor(.white)
                    }

                    Link(destination: URL(string: "https://landing.flycricket.io/style-di-venezia-diary/b1625a15-0b31-4221-9e99-8b841652b674/?t=1745438674")!) {
                        Label("About the Developers", systemImage: "headphones")
                            .foregroundColor(.white)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .background(Color.black)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }
}
