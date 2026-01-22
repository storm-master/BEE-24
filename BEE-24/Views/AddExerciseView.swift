import SwiftUI

struct AddExerciseView: View {
    @Binding var isPresented: Bool
    var editingExercise: ExerciseModel? = nil
    var onSave: () -> Void = {}
    
    @State private var targetDistance: String = ""
    @State private var repetitions: String = ""
    @State private var name: String = ""
    @State private var notes: String = ""
    @State private var date: Date = Date()
    @State private var showCalendar: Bool = false
    
    private var isEditing: Bool {
        editingExercise != nil
    }
    
    private var isFormValid: Bool {
        !targetDistance.isEmpty && !repetitions.isEmpty && !name.isEmpty
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                ScrollView {
                    VStack(spacing: 5) {
                        // Header
                        HStack {
                            Text(isEditing ? "Edit training" : "Add training")
                                .font(.appFont(size: 30))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                if isFormValid {
                                    saveExercise()
                                }
                            } label: {
                                Image(isFormValid ? .doneButton : .doneButtonOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110, height: 55)
                            }
                        }
                        
                        // Target Distance & Repetitions
                        HStack(spacing: 5) {
                            NumberInputCell(title: "Target Distance", value: $targetDistance)
                            NumberInputCell(title: "Repetitions", value: $repetitions)
                        }
                        
                        // Name
                        InputView(placeholder: "Name", text: $name)
                        
                        // Notes
                        InputView(placeholder: "Notes", text: $notes, isMultiline: true)
                        
                        // Date Picker
                        VStack(spacing: 5) {
                            Button {
                                withAnimation {
                                    showCalendar.toggle()
                                }
                            } label: {
                                HStack {
                                    Text(formattedDate.isEmpty ? "Date" : formattedDate)
                                        .font(.appFont(size: 23))
                                        .foregroundColor(formattedDate.isEmpty ? .white.opacity(0.5) : .white)
                                    
                                    Spacer()
                                    
                                    Image(.arrowDown)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45, height: 45)
                                        .rotationEffect(.degrees(showCalendar ? 180 : 0))
                                }
                                .padding(20)
                                .background(Color.appGreenSecondary)
                                .cornerRadius(20)
                            }
                            
                            if showCalendar {
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .tint(.white)
                                    .colorScheme(.dark)
                                    .padding()
                                    .background(Color.appGreenSecondary)
                                    .cornerRadius(26)
                                    .onChange(of: date) { _ in
                                        withAnimation {
                                            showCalendar = false
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(Color.appGreenDark)
            .cornerRadius(35)
            .padding(.horizontal, 20)
            .padding(.vertical, 60)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .onAppear {
            if let exercise = editingExercise {
                targetDistance = String(exercise.targetDistance)
                repetitions = String(exercise.repetitions)
                name = exercise.name
                notes = exercise.notes
                date = exercise.date
            }
        }
    }
    
    private func saveExercise() {
        if let existingExercise = editingExercise {
            var updatedExercise = existingExercise
            updatedExercise.name = name
            updatedExercise.notes = notes
            updatedExercise.date = date
            updatedExercise.targetDistance = Int(targetDistance) ?? 0
            updatedExercise.repetitions = Int(repetitions) ?? 0
            ExerciseService.shared.update(updatedExercise)
        } else {
            let exercise = ExerciseModel(
                name: name,
                notes: notes,
                date: date,
                targetDistance: Int(targetDistance) ?? 0,
                repetitions: Int(repetitions) ?? 0
            )
            ExerciseService.shared.add(exercise)
        }
        onSave()
        isPresented = false
    }
}

struct NumberInputCell: View {
    let title: String
    @Binding var value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.appFont(size: 16))
                .foregroundColor(.white.opacity(0.5))
            
            TextField("", text: $value, prompt: Text("0").foregroundColor(.white.opacity(0.5)))
                .font(.appFont(size: 45))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: value) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count > 3 {
                        value = String(filtered.prefix(3))
                    } else {
                        value = filtered
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 126)
        .padding(.horizontal, 16)
        .background(Color.appGreenSecondary)
        .cornerRadius(20)
    }
}

#Preview {
    AddExerciseView(isPresented: .constant(true))
}
