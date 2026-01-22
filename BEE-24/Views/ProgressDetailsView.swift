import SwiftUI

struct ProgressDetailsView: View {
    let progress: ProgressModel
    @Environment(\.dismiss) private var dismiss
    @State private var showEditView: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var currentProgress: ProgressModel
    
    init(progress: ProgressModel) {
        self.progress = progress
        self._currentProgress = State(initialValue: progress)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: currentProgress.date)
    }
    
    var body: some View {
        ZStack {
            VStack {
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
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Best Attempt")
                                .font(.appFont(size: 17))
                                .foregroundColor(.white.opacity(0.5))
                            
                            HStack(alignment: .bottom, spacing: 4) {
                                Text("\(currentProgress.result)/\(currentProgress.goal)")
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
                    .padding(.bottom, 8)
                    
                    Text(formattedDate)
                        .font(.appFont(size: 25))
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.bottom, 8)

                    Text("Notes")
                        .font(.appFont(size: 22))
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(currentProgress.notes.isEmpty ? "-" : currentProgress.notes)
                        .font(.appFont(size: 25))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color.appGreenDark)
                .cornerRadius(35)
                
                Spacer()
                
                HStack(spacing: 10) {
                    Button {
                        showEditView = true
                    } label: {
                        Image(.editButton)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 85)
                    }
                    
                    Button {
                        showDeleteAlert = true
                    } label: {
                        Image(.deleteButton)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 85)
                    }
                }
            }
            .padding(.horizontal, 20)
            .bgSetup()
            
            if showEditView {
                AddProgressView(
                    isPresented: $showEditView,
                    editingProgress: currentProgress
                ) {
                    currentProgress = ProgressService.shared.getAll().first { $0.id == progress.id } ?? currentProgress
                }
            }
            
            if showDeleteAlert {
                DeleteAlertView(
                    isPresented: $showDeleteAlert,
                    onDelete: {
                        ProgressService.shared.delete(currentProgress)
                        dismiss()
                    }
                )
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ProgressDetailsView(progress: ProgressModel(
        result: 45,
        goal: 50,
        notes: "Good session",
        date: Date()
    ))
}
