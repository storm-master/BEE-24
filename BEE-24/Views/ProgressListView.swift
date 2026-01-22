import SwiftUI

struct ProgressListView: View {
    @Binding var showAddProgress: Bool
    var refreshTrigger: Bool = false
    @State private var progressList: [ProgressModel] = []
    
    var body: some View {
        Group {
            if progressList.isEmpty {
                VStack(spacing: 5) {
                    Spacer()
                    EmptyInfoView(
                        title: "No progress recorded yet",
                        description: "Tracking performance helps you see improvement and focus on areas to work on"
                    ) {
                        showAddProgress = true
                    }
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(progressList) { progress in
                            NavigationLink {
                                ProgressDetailsView(progress: progress)
                            } label: {
                                ProgressCell(progress: progress)
                            }
                        }
                        
                        Button {
                            showAddProgress = true
                        } label: {
                            Image(.addButton)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 169, height: 110)
                        }
                    }
                }
            }
        }
        .onAppear {
            progressList = ProgressService.shared.getAll()
        }
        .onChange(of: refreshTrigger) { _ in
            progressList = ProgressService.shared.getAll()
        }
    }
}

struct ProgressCell: View {
    let progress: ProgressModel
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: progress.date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(formattedDate)
                .font(.appFont(size: 25))
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.leading)

            HStack {
                Text(progress.notes)
                    .font(.appFont(size: 25))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Best Attempt")
                        .font(.appFont(size: 17))
                        .foregroundColor(.white.opacity(0.5))
                    
                    HStack(alignment: .bottom, spacing: 4) {
                        Text("\(progress.result)/\(progress.goal)")
                            .font(.appFont(size: 50))
                            .foregroundColor(.white)
                        
                        Text("hits")
                            .font(.appFont(size: 18))
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                    }
                }
            }
            .padding()
            .frame(height: 120)
            .background(Color.appGreenSecondary)
            .cornerRadius(23)
        }
        .padding()
        .background(Color.appGreenDark)
        .cornerRadius(35)
    }
}

#Preview {
    ProgressListView(showAddProgress: .constant(false))
}
