import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategory: String

    let categories = ["Clothes", "Shoes", "Accessories"]

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ScrollView {
                    VStack(spacing: geometry.size.height * 0.03) {
                
                        Text("Filters")
                            .font(.system(size: geometry.size.width * 0.06, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, geometry.size.height * 0.08)

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Category")
                                .foregroundColor(.white)
                                .font(.system(size: geometry.size.width * 0.045, weight: .medium))

                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 12) {
                                ForEach(categories, id: \.self) { cat in
                                    Button(action: {
                                        selectedCategory = (selectedCategory == cat) ? "" : cat
                                    }) {
                                        Text(cat)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(selectedCategory == cat ? Color.yellow : Color.white)
                                            .foregroundColor(.black)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        Spacer(minLength: geometry.size.height * 0.2)

                        Button(action: {
                            dismiss()
                        }) {
                            Text("Apply")
                                .font(.system(size: geometry.size.width * 0.045, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(30)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 40)
                    }
                    .frame(minHeight: geometry.size.height)
                }

                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .imageScale(.medium)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Circle())
                }
                .padding(.leading)
                .padding(.top, geometry.safeAreaInsets.top + 10)
            }
            .background(Color.black.ignoresSafeArea())
        }
    }
}
