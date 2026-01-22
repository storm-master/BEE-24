import SwiftUI

struct TrainingMainView: View {
    @State private var showTraining: Bool = false
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
            VStack {
                Text("Ready to start training?")
                    .font(.appFont(size: 45))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                NavigationLink {
                    TrainingView()
                        .navigationBarHidden(true)
                } label: {
                    Image(.startButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 169, height: 110)
                }
            }
            .padding()
            .background(Color.appGreenDark)
            .cornerRadius(35)
            Spacer()
        }
    }
}

#Preview {
    TrainingMainView()
}
