import SwiftUI

struct MainViewHeaderView: View {
    let title: String
    var onSettingsTap: () -> Void = {}
    
    var body: some View {
        HStack {
            Text(title)
                .font(.appFont(size: 45))
                .foregroundColor(.white)
                .stroke(color: .appTextStroke, width: 1)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    LinearGradient(
                        colors: [.appGreenLight, .appGreenSuperLight, .appGreenLight],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(26)
                .padding(.trailing, 30)
            
            Spacer()
            
            Button {
                onSettingsTap()
            } label: {
                Image(.settingsButton)
                    .frame(width: 90, height: 90)
            }
        }
    }
}

#Preview {
    MainViewHeaderView(title: "Archery\nBasics")
}
