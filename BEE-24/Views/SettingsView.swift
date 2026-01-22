import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showAboutApp: Bool = false
    @State private var showPrivacyPolicy: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
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
            
            VStack(spacing: 4) {
                Text("Your level")
                    .font(.appFont(size: 25))
                    .foregroundColor(.white)
                
                Text("4")
                    .font(.appFont(size: 55))
                    .foregroundColor(.white)
            }
            .padding(.vertical, 23)
            .padding(.horizontal, 35)
            .background(Color.appGreenDark)
            .cornerRadius(23)
            
            SettingsRowView(title: "About app") {
                showAboutApp = true
            }
            .padding(.trailing, 20)
            .navigationDestination(isPresented: $showAboutApp) {
                WebViewScreen(url: "https://www.termsfeed.com/live/8cd10c96-1052-4295-8d0f-b421b708ad9c")
            }

            SettingsRowView(title: "Privacy Policy") {
                showPrivacyPolicy = true
            }
            .padding(.trailing, 20)
            .navigationDestination(isPresented: $showPrivacyPolicy) {
                WebViewScreen(url: "https://www.termsfeed.com/live/8cd10c96-1052-4295-8d0f-b421b708ad9c")
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .bgSetup()
        .navigationBarHidden(true)
    }
}

struct SettingsRowView: View {
    let title: String
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            ZStack(alignment: .topTrailing) {
                HStack {
                    Text(title)
                        .font(.appFont(size: 25))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 95)
                .background(Color.appGreenDark)
                .cornerRadius(23)
                
                Image(.arrowDown)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .rotationEffect(.degrees(-120))
                    .offset(x: 20, y: -20)
            }
        }
    }
}

#Preview {
    SettingsView()
}
