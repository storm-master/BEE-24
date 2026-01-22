import SwiftUI

struct ExercisesView: View {
    @Binding var showAddExercise: Bool
    var refreshTrigger: Bool = false
    @State private var exercises: [ExerciseModel] = []
    
    var body: some View {
        Group {
            if exercises.isEmpty {
                VStack(spacing: 5) {
                    Spacer()
                EmptyInfoView(
                    title: "No exercises scheduled yet",
                    description: "Regular practice is the key to steady improvement"
                ) {
                    showAddExercise = true
                }
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(exercises) { exercise in
                            NavigationLink {
                                ExerciseDetailView(exercise: exercise)
                            } label: {
                                ExerciseCell(exercise: exercise)
                            }
                        }
                        
                        Button {
                            showAddExercise = true
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
            exercises = ExerciseService.shared.getAll()
        }
        .onChange(of: refreshTrigger) { _ in
            exercises = ExerciseService.shared.getAll()
        }
    }
}

struct ExerciseCell: View {
    let exercise: ExerciseModel
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: exercise.date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(exercise.name)
                .font(.appFont(size: 25))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(formattedDate)
                .font(.appFont(size: 25))
                .foregroundColor(.white.opacity(0.5))
            
            HStack(spacing: 5) {
                ExerciseStatView(title: "Target Distance", value: "\(exercise.targetDistance)M")
                ExerciseStatView(title: "Repetitions", value: "\(exercise.repetitions)")
            }
        }
        .padding()
        .background(Color.appGreenDark)
        .cornerRadius(35)
    }
}

struct ExerciseStatView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.appFont(size: 14))
                .foregroundColor(.white.opacity(0.5))
            
            Text(value)
                .font(.appFont(size: 50))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.appGreenSecondary)
        .cornerRadius(25)
    }
}

#Preview {
    ExercisesView(showAddExercise: .constant(false))
}
