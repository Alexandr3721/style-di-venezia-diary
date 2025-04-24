import SwiftUI

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let content: String
}

let articles: [Article] = [
    Article(
        title: "Seasonal Fashion Trends",
        imageName: "Articles-1",
        content: """
Fashion trends evolve each season, influenced by designers, street style, and cultural shifts.

Here are the key trends for this year:

Spring/Summer Trends
• Soft Pastels – Shades like lavender, mint, and baby blue dominate wardrobes.
• Linen Everything – Lightweight and breathable fabrics for effortless elegance.
• Statement Accessories – Oversized sunglasses, chunky chains, and mini bags.
• Sheer Layers – Flowing translucent fabrics add depth to outfits.
• Bold Florals – Vibrant prints inspired by blooming gardens.

Fall/Winter Trends
• Chunky Knits – Cozy, oversized sweaters for a warm and stylish look.
• Leather Revival – Leather coats, pants, and boots create an edgy vibe.
• Deep Jewel Tones – Emerald green, sapphire blue, and ruby red.
• Structured Blazers – Power dressing with sharp tailoring.
• Tall Boots – Knee-high and over-the-knee boots are back in style.
"""
    ),
    Article(
        title: "How to Build a Capsule Wardrobe",
        imageName: "Articles-2",
        content: """
A capsule wardrobe is a collection of versatile, timeless pieces that mix and match effortlessly.

Follow these steps to curate the perfect foundation:

Step 1: Choose a Neutral Color Palette
Stick to black, white, beige, navy, and gray for a cohesive look.

Step 2: Invest in Essentials
Tops: Classic white shirt, neutral turtleneck, striped tee.
Bottoms: Well-fitted jeans, tailored trousers, A-line skirt.
Outerwear: Blazer, trench coat, wool coat.
Shoes: White sneakers, ankle boots, classic pumps.

Step 3: Add a Few Statement Pieces
Introduce seasonal trends and pops of color to keep your wardrobe fresh.

Step 4: Keep It Minimal
Quality over quantity – invest in high-quality, durable fabrics.
"""
    ),
    Article(
        title: "Dressing for Your Body Shape",
        imageName: "Articles-3",
        content: """
Understanding your body type can help you enhance your best features and dress with confidence.

Hourglass (X-Shape)
🔷 Key Features: Balanced shoulders and hips, defined waist.
✅ Best Styles: Wrap dresses, belted coats, fitted tops.
🚫 Avoid: Oversized silhouettes that hide your waist.

Pear (A-Shape)
🔷 Key Features: Narrow shoulders, wider hips.
✅ Best Styles: A-line skirts, off-shoulder tops, structured blazers.
🚫 Avoid: Skinny jeans without balancing the upper body.

Apple (O-Shape)
🔷 Key Features: Full midsection, slimmer legs.
✅ Best Styles: Empire waist dresses, flowy tops, straight-leg pants.
🚫 Avoid: Tight-fitting tops that emphasize the midsection.

Rectangle (H-Shape)
🔷 Key Features: Balanced shoulders, waist, and hips.
✅ Best Styles: Peplum tops, high-waisted pants, layered outfits.
🚫 Avoid: Boxy shapes that don’t define the waist.

Inverted Triangle (V-Shape)
🔷 Key Features: Broad shoulders, narrow hips.
✅ Best Styles: Flared pants, skirts, V-neck tops.
🚫 Avoid: Padded shoulders or wide-neck tops.
"""
    ),
    Article(
        title: "Color Combinations & Capsule Wardrobes",
        imageName: "Articles-4",
        content: """
Color coordination plays a crucial role in building a functional and stylish wardrobe.

Basic Color Pairings
Monochrome – Different shades of one color (e.g., all beige).
Complementary – Opposite colors on the color wheel (e.g., blue & orange).
Analogous – Colors next to each other on the wheel (e.g., blue & green).

Capsule Wardrobe Color Strategy
Base Colors: Black, white, gray, navy – versatile and timeless.
Accent Colors: Burgundy, emerald, mustard – to add personality.
Seasonal Colors: Pastels for spring, deep tones for winter.
"""
    )
]

struct ArticlesView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            HStack {
                                Image(article.imageName)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(article.title)
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                    Spacer()
                                    Text("Read more")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 6)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]),
                                                           startPoint: .leading, endPoint: .trailing)
                                        )
                                        .cornerRadius(20)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(16)
                        }
                    }
                }
                .padding(.bottom, 100)
                .padding(.horizontal)
            }
            .background(Color.black)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Useful articles")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
        }
    }
}

struct ArticleDetailView: View {
    @Environment(\.dismiss) var dismiss
    var article: Article

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                }

                Spacer()

                Text("Details")
                    .foregroundColor(.white)
                    .font(.headline)

                Spacer()

                Spacer() 
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .padding(.bottom, 10)
            .background(Color(red: 0.14, green: 0.14, blue: 0.14))

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Image(article.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)

                    Text(article.title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)

                    Text(article.content)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .padding(.bottom, 80)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
