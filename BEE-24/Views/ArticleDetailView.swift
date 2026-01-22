import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(.backButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 135, height: 90)
                }
                Spacer()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Image(article.image)
                        .resizable()
                        .scaledToFit()
                        .mask(Image(.folderShape).resizable().scaledToFit())
                    
                    Text(article.title)
                        .font(.appFont(size: 35))
                        .foregroundColor(.white)
                    
                    Text(article.description)
                        .font(.appFontSec(size: 22))
                        .foregroundColor(.white.opacity(0.5))
                    
                    Text("Tips")
                        .font(.appFont(size: 30))
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(article.tips, id: \.self) { tip in
                            HStack(alignment: .top) {
                                Text("•")
                                    .font(.appFontSec(size: 22))
                                    .foregroundColor(.white.opacity(0.5))
                                Text(tip)
                                    .font(.appFontSec(size: 22))
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.appGreenDark)
            .cornerRadius(35)
        }
        .padding(.horizontal, 20)
        .bgSetup()
    }
}

#Preview {
    ArticleDetailView(article: .archeryBasics)
}
