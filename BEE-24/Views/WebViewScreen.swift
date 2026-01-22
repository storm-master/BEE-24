import SwiftUI
import WebKit

struct WebViewScreen: View {
    @Environment(\.dismiss) private var dismiss
    let url: String
    
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
            .padding(.horizontal, 20)
            
            WebView(url: URL(string: url)!)
                .ignoresSafeArea(edges: .bottom)
        }
        .bgSetup()
        .navigationBarHidden(true)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    WebViewScreen(url: "https://www.google.com")
}

