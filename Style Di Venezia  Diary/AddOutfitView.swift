import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct AddOutfitView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var imageName = ""
    @State private var selectedSeasons: Set<String> = []
    @State private var selectedStyles: Set<String> = []
    @State private var selectedBodyTypes: Set<String> = []
    @State private var usedImagesText = ""
    @State private var selectedImage: UIImage? = nil
    @State private var photoItem: PhotosPickerItem? = nil

    var onAdd: (Outfit) -> Void

    let allSeasons = ["Spring", "Summer", "Fall", "Winter"]
    let allStyles = ["Classic", "Athleisure", "Boho", "Grunge", "Romantic"]
    let allBodyTypes = ["Hourglass", "Pear", "Apple", "Rectangle"]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
             
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50)

                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Image")
                                .foregroundColor(.white)
                                .font(.subheadline)

                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .cornerRadius(12)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 150)
                                    .overlay(
                                        Text("No image selected")
                                            .foregroundColor(.white.opacity(0.7))
                                    )
                                    .cornerRadius(12)
                            }

                            PhotosPicker("Select Image", selection: $photoItem, matching: .images)
                                .buttonStyle(.borderedProminent)
                        }
                        .onChange(of: photoItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    selectedImage = uiImage
                                    imageName = saveImageToDocuments(uiImage)
                                }
                            }
                        }

                        FilterSection(title: "Fashion seasons", options: allSeasons, selection: $selectedSeasons)
                        FilterSection(title: "Clothing styles", options: allStyles, selection: $selectedStyles)
                        FilterSection(title: "Body types", options: allBodyTypes, selection: $selectedBodyTypes)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Title")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            TextField("Outfit name", text: $title)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 80)
                }

                Button(action: {
                    let outfit = Outfit(
                        id: UUID(),
                        imageName: imageName,
                        title: title,
                        tags: Array(selectedSeasons) + Array(selectedStyles) + Array(selectedBodyTypes),
                        usedImages: []
                    )
                    onAdd(outfit)
                    dismiss()
                }) {
                    Text("Apply")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                           startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                }
                .disabled(title.isEmpty || imageName.isEmpty)
            }
            .background(Color.black.ignoresSafeArea())
        }
    }

    func saveImageToDocuments(_ image: UIImage) -> String {
        let imageName = UUID().uuidString + ".jpg"
        if let data = image.jpegData(compressionQuality: 0.8) {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
            try? data.write(to: url)
        }
        return imageName
    }
}


struct FilterSection: View {
    let title: String
    let options: [String]
    @Binding var selection: Set<String>

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)

            GeometryReader { geometry in
                FlexibleView(data: options, spacing: 8, alignment: .leading) { item in
                    Button(action: {
                        if selection.contains(item) {
                            selection.remove(item)
                        } else {
                            selection.insert(item)
                        }
                    }) {
                        Text(item)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection.contains(item) ? Color.yellow : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                }
                .frame(width: geometry.size.width)
            }
            .frame(height: 100)
        }
    }
}

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    init(data: Data, spacing: CGFloat, alignment: HorizontalAlignment, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var rows: [[Data.Element]] = [[]]

        for item in data {
            let itemWidth: CGFloat = 100

            if width + itemWidth + spacing > geometry.size.width {
                rows.append([item])
                width = itemWidth + spacing
            } else {
                rows[rows.count - 1].append(item)
                width += itemWidth + spacing
            }
        }

        return VStack(alignment: alignment, spacing: spacing) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }
}
