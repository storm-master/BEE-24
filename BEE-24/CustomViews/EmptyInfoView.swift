import SwiftUI

struct EmptyInfoView: View {
    let title: String
    let description: String
    var onAddTap: () -> Void = {}
    
    var body: some View {
        VStack {
            Text(title.uppercased())
                .font(.appFont(size: 35))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            Text(description.uppercased())
                .font(.appFontSec(size: 25))
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)

            Button {
                onAddTap()
            } label: {
                Image(.addButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 169, height: 110)
            }
        }
        .padding()
        .background(Color.appGreenDark)
        .cornerRadius(35)
    }
}

#Preview {
    EmptyInfoView(title: "No Exercises", description: "Add your first exercise")
}
