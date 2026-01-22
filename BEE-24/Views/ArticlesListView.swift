import SwiftUI

struct ArticlesListView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Article.allCases, id: \.self) { article in
                    NavigationLink {
                        ArticleDetailView(article: article)
                    } label: {
                        ArticleCell(article: article)
                    }
                }
            }
        }
    }
}

struct ArticleCell: View {
    let article: Article
    
    var body: some View {
        HStack {
            Image(article.image)
                .resizable()
                .scaledToFill()
                .frame(width: 144, height: 144)
                .cornerRadius(33)
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.appFont(size: 25))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text(article.description)
                    .font(.appFontSec(size: 16))
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 120, alignment: .leading)
        }
        .padding(7)
        .background(Color.appGreenDark)
        .cornerRadius(35)
    }
}

#Preview {
    ArticlesListView()
}
