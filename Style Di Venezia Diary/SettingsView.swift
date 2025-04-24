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
                    Link(destination: URL(string: "https://example.com/terms")!) {
                        Label("Terms of Use", systemImage: "doc.text")
                            .foregroundColor(.white)
                    }

                    Link(destination: URL(string: "https://example.com/privacy")!) {
                        Label("Privacy Policy", systemImage: "shield")
                            .foregroundColor(.white)
                    }

                    Link(destination: URL(string: "https://example.com/about")!) {
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
