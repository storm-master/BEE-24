import SwiftUI

struct ExerciseDetailView: View {
    let exercise: ExerciseModel
    @Environment(\.dismiss) private var dismiss
    @State private var showEditView: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var currentExercise: ExerciseModel
    
    init(exercise: ExerciseModel) {
        self.exercise = exercise
        self._currentExercise = State(initialValue: exercise)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: currentExercise.date)
    }
    
    var body: some View {
        ZStack {
            VStack {
                // Header
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
                
                // Cell
                VStack(alignment: .leading, spacing: 8) {
                    Text(currentExercise.name)
                        .font(.appFont(size: 25))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formattedDate)
                        .font(.appFont(size: 25))
                        .foregroundColor(.white.opacity(0.5))
                    
                    HStack(spacing: 5) {
                        ExerciseStatView(title: "Target Distance", value: "\(currentExercise.targetDistance)M")
                        ExerciseStatView(title: "Repetitions", value: "\(currentExercise.repetitions)")
                    }
                    
                    Text("Notes")
                        .font(.appFont(size: 22))
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(currentExercise.notes.isEmpty ? "-" : currentExercise.notes)
                        .font(.appFont(size: 25))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color.appGreenDark)
                .cornerRadius(35)
                
                Spacer()
                
                // Bottom buttons
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
                AddExerciseView(
                    isPresented: $showEditView,
                    editingExercise: currentExercise
                ) {
                    currentExercise = ExerciseService.shared.getAll().first { $0.id == exercise.id } ?? currentExercise
                }
            }
            
            if showDeleteAlert {
                DeleteAlertView(
                    isPresented: $showDeleteAlert,
                    onDelete: {
                        ExerciseService.shared.delete(currentExercise)
                        dismiss()
                    }
                )
            }
        }
        .navigationBarHidden(true)
    }
}

struct DeleteAlertView: View {
    @Binding var isPresented: Bool
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 16) {
                Text("Delete")
                    .font(.appFont(size: 45))
                    .foregroundColor(.white)
                
                Text("Are you sure you want to delete this entry?")
                    .font(.appFontSec(size: 25))
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
                
                Text("This action cannot be undone")
                    .font(.appFontSec(size: 20))
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 0) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(.cancelButton)
                            .resizable()
                            .frame(width: 150, height: 60)
                            .scaledToFill()
                    }
                    
                    Button {
                        onDelete()
                        isPresented = false
                    } label: {
                        Image(.deleteButton)
                            .resizable()
                            .frame(width: 150, height: 60)
                            .scaledToFill()
                    }
                }
            }
            .padding(20)
            .background(Color.appGreenDark)
            .cornerRadius(35)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    ExerciseDetailView(exercise: ExerciseModel(
        name: "Morning Practice",
        notes: "Focus on form",
        date: Date(),
        targetDistance: 25,
        repetitions: 50
    ))
}
