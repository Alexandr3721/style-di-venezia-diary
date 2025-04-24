import SwiftUI

struct AddWishlistItemView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var price: String = ""
    @State private var category: String = ""
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false

    var onAdd: (WishlistItem) -> Void

    var body: some View {
        VStack(spacing: 20) {
    
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                }
                Spacer()
                Text("New object")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 70)
            .padding(.bottom, 10)
            .background(Color(red: 0.14, green: 0.14, blue: 0.14))

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Cover")
                        .foregroundColor(.white)

                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .frame(height: 200)

                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(12)
                        } else {
                            Image(systemName: "plus")
                                .foregroundColor(.yellow)
                        }
                    }
                    .onTapGesture {
                        showImagePicker = true
                    }

                    Group {
                        TextField("Enter title", text: $title)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)

                        TextField("Enter price", text: $price)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)

                        TextField("Enter category", text: $category)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }

            Button(action: {
                let newItem = WishlistItem(
                    id: UUID(),
                    title: title,
                    price: price,
                    category: category,
                    imageData: image?.jpegData(compressionQuality: 0.8),
                    bought: false
                )
                onAdd(newItem)
                dismiss()
            }) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .cornerRadius(30)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            }
            .disabled(title.isEmpty || price.isEmpty || category.isEmpty)
        }
        .background(Color.black.ignoresSafeArea())
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}
